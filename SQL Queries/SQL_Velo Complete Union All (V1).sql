-- !preview conn=DBI::dbConnect(RSQLite::SQLite())

## Suggestions from ChatGPT
## This would achieve a daily count for all the different counters. However

-- SUM(compteur_100003034) AS compteur_100003034,
-- 	SUM(compteur_100003039) AS compteur_100003039,
-- 	SUM(compteur_100057500) AS compteur_100057500,
-- 	SUM(compteur_100004575) AS compteur_100004575,
-- 	SUM(compteur_100003032) AS compteur_100003032,
-- 	SUM(compteur_100003040) AS compteur_100003040,
-- 	SUM(compteur_100003041) AS compteur_100003041,
-- 	SUM(compteur_100003042) AS compteur_100003042,
-- 	SUM(compteur_100002880) AS compteur_100002880,
-- 	SUM(compteur_100007390) AS compteur_100007390,
-- 	SUM(compteur_100011747) AS compteur_100011747,
-- 	SUM(compteur_100011748) AS compteur_100011748,
-- 	SUM(compteur_100011783) AS compteur_100011783,
-- 	SUM(compteur_100012217) AS compteur_100012217,
-- 	SUM(compteur_100012218) AS compteur_100012218,
-- 	SUM(compteur_100017441) AS compteur_100017441,
-- 	SUM(compteur_100001753) AS compteur_100001753,
-- 	SUM(compteur_100047030) AS compteur_100047030,
-- 	SUM(compteur_100017523) AS compteur_100017523,
-- 	SUM(compteur_38) AS compteur_38,
-- 	SUM(compteur_39) AS compteur_39,
-- 	SUM(compteur_100025474) AS compteur_100025474,
-- 	SUM(compteur_100034805) AS compteur_100034805,
-- 	SUM(compteur_100035408) AS compteur_100035408,
-- 	SUM(compteur_100035409) AS compteur_100035409,
-- 	SUM(compteur_100041101) AS compteur_100041101,
-- 	SUM(compteur_100041114) AS compteur_100041114,
-- 	SUM(compteur_100052600) AS compteur_100052600,
-- 	SUM(compteur_100052601) AS compteur_100052601,
-- 	SUM(compteur_100052602) AS compteur_100052602,
-- 	SUM(compteur_100052603) AS compteur_100052603,
-- 	SUM(compteur_100052604) AS compteur_100052604,
-- 	SUM(compteur_100052605) AS compteur_100052605,
-- 	SUM(compteur_100052606) AS compteur_100052606,
-- 	SUM(compteur_100053055) AS compteur_100053055,
-- 	SUM(compteur_100053057) AS compteur_100053057,
-- 	SUM(compteur_100053058) AS compteur_100053058,
-- 	SUM(compteur_100053059) AS compteur_100053059,
-- 	SUM(compteur_100053210) AS compteur_100053210,
-- 	SUM(compteur_100054073) AS compteur_100054073,
-- 	SUM(compteur_100056188) AS compteur_100056188,
-- 	SUM(compteur_100057050) AS compteur_100057050,
-- 	SUM(compteur_100057051) AS compteur_100057051,
-- 	SUM(compteur_100057052) AS compteur_100057052,
-- 	SUM(compteur_100057053) AS compteur_100057053,
-- 	SUM(compteur_100053209) AS compteur_100053209,
-- 	SUM(compteur_100054585) AS compteur_100054585,
-- 	SUM(compteur_100055268) AS compteur_100055268,
-- 	SUM(compteur_100054241) AS compteur_100054241,
-- 	SUM(compteur_300014993) AS compteur_300014993,
-- 	SUM(compteur_300014986) AS compteur_300014986,
-- 	SUM(compteur_300014985) AS compteur_300014985,
-- 	SUM(compteur_300014995) AS compteur_300014995,
-- 	SUM(compteur_300014996) AS compteur_300014996,
-- 	SUM(compteur_300014916) AS compteur_300014916,
-- 	SUM(compteur_300014994) AS compteur_300014994,
-- 	SUM(compteur_300020478) AS compteur_300020478
INSERT INTO velo_complete
SELECT *
FROM (
	SELECT *
	FROM velo2009_complete
	UNION ALL
	SELECT *
	FROM velo2010_complete
	UNION ALL
	SELECT *
	FROM velo2011_complete
	UNION ALL
	SELECT *
	FROM velo2012_complete
	UNION ALL
	SELECT *
	FROM velo2013_complete
	UNION ALL
	SELECT *
	FROM velo2014_complete
	UNION ALL
	SELECT *
	FROM velo2015_complete
	UNION ALL
	SELECT *
	FROM velo2016_complete
	UNION ALL
	SELECT *
	FROM velo2017_complete
	UNION ALL
	SELECT *
	FROM velo2018_complete
	UNION ALL
	SELECT *
	FROM velo2019_complete
	UNION ALL
	SELECT *
	FROM velo2020_complete
	UNION ALL
	SELECT *
	FROM velo2021_complete
	UNION ALL
	SELECT *
	FROM velo2022_complete
) AS new_values

-- SELECT date,
-- --        SUM(compteur_100003034) AS compteur_100003034,
-- --        SUM(compteur_100003039) AS compteur_100003039,
-- --        SUM(compteur_100057500) AS compteur_100057500,
-- --        SUM(compteur_100004575) AS compteur_100004575,
-- --        SUM(compteur_100003032) AS compteur_100003032
-- -- FROM velo_2009
-- -- UNION ALL
-- -- FROM velo_2010
-- -- UNION ALL
-- -- [...]
-- -- FROM velo_2022





-- RENAME TABLE old_table_name TO new_table_name;