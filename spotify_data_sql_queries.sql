create database spotify;
rename table cleaned_dataset to spotify_data;

select * from spotify_data;

select count(*) from spotify_data;

select max(duration_min) from spotify_data;

select min(duration_min) from spotify_data;

select distinct artist from spotify_data;

select count(distinct artist) from spotify_data;

select distinct most_playedon from spotify_data;

-- Easy Queries --
-- 1. Retrieve the names of all tracks that have more than 1 billion streams.--

SELECT 
    track, stream
FROM
    spotify_data
WHERE
    Stream > 1000000000;

-- 2. List all albums along with their respective artists.--

SELECT DISTINCT
    Album, artist
FROM
    spotify_data;
SELECT 
    album, artist
FROM
    spotify_data
ORDER BY 1;

-- 3. Get the total number of comments for tracks where licensed = TRUE.--
SELECT 
    SUM(comments)
FROM
    spotify_data
WHERE
    Licensed = 'TRUE';

-- 4. Find all tracks that belong to the album type single. --

SELECT 
    track
FROM
    spotify_data
WHERE
    Album_type = 'single';

-- 5. Count the total number of tracks by each artist. --

SELECT DISTINCT
    artist, COUNT(track) AS no_of_track
FROM
    spotify_data
GROUP BY artist
ORDER BY COUNT(track);


-- ----------------------------------------------------------------- --
-- Medium Level --
-- ----------------------------------------------------------------- --

-- 1. Calculate the average danceability of tracks in each album. --

SELECT 
    album, AVG(danceability) AS avg_danceability
FROM
    spotify_data
GROUP BY album
ORDER BY AVG(danceability) DESC;

-- 2. Find the top 5 tracks with the highest energy values.--

SELECT 
    track, Energy
FROM
    spotify_data
ORDER BY Energy DESC
LIMIT 5; 

-- 3. List all tracks along with their views and likes where official_video = TRUE.--

SELECT 
    track, SUM(VIEWS) AS total_views, SUM(LIKES) AS total_likes
FROM
    spotify_data
WHERE
    official_video = 'TRUE'
GROUP BY TRACK;


-- 4. For each album, calculate the total views of all associated tracks. --

select album,track,sum(views) as total_views from spotify_data
group by Album,track; 


-- 5. Retrieve the track names that have been streamed on Spotify more than YouTube. --

SELECT *
FROM (
    SELECT
        track,
        COALESCE(SUM(CASE WHEN most_playedon = 'youtube' THEN stream END), 0) AS streamed_on_youtube,
        COALESCE(SUM(CASE WHEN most_playedon = 'spotify' THEN stream END), 0) AS streamed_on_spotify
    FROM spotify_data
    GROUP BY track
) AS table1
WHERE streamed_on_spotify > streamed_on_youtube;


-- -------------------------------------------------------- --
          -- Advance level --
-- -------------------------------------------------------- --

-- 1. Find the top 3 most-viewed tracks for each artist using window functions. --

WITH ranking_artist AS 
(
  SELECT 
    artist,
    track,
    SUM(views) AS total_views,
    DENSE_RANK() OVER (
      PARTITION BY artist 
      ORDER BY SUM(views) DESC
    ) AS ranking
  FROM spotify_data
  GROUP BY artist, track
)
SELECT * 
FROM ranking_artist
WHERE ranking <= 3
ORDER BY artist, total_views DESC;

 -- 2. Write a query to find tracks where the liveness score is above the average. --
    
	SELECT 
    AVG(liveness) AS avg_liveness
FROM
    spotify_data;-- 0.1935698324022347
    
SELECT 
    track, liveness
FROM
    spotify_data
WHERE
    liveness > (SELECT 
            AVG(liveness) AS avg_liveness
        FROM
            spotify_data)
            order by liveness desc;
    

-- 3. Use a WITH clause to calculate the difference between the highest and 
-- lowest energy values for tracks in each album.--

with cte
as (
select album,max(energy) as highest_energy,
min(energy) as lowest_energy from spotify_data
group by album)
select album, 
highest_energy - lowest_energy as energy_diff
from cte
order by energy_diff desc;


-- 4. Find tracks where the energy-to-liveness ratio is greater than 1.2. --

SELECT 
    track, Energy, liveness
FROM
    spotify_data
WHERE
    energy / liveness > 1.2;

-- 5. Calculate the cumulative sum of likes for tracks 
-- ordered by the number of views, using window functions.

SELECT track,
       likes,
       views,
       SUM(likes) OVER (ORDER BY views) AS cumulative_likes
FROM spotify_data;

-- ----------------------------------------------------------------- --
                          END
-- ----------------------------------------------------------------- --
