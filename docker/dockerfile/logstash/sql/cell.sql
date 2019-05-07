SELECT tci.ciid,
       tci.cell_name cellName,
       tci.longitude,
       tci.latitude,
       concat(tci.latitude, ',', tci.longitude) location,
       tci.geohash_key geohashKey,
       tci.address,
       tci.people_count peopleCount,
       tci.update_time updateTime
FROM t_cell_info tci
WHERE tci.update_time > :sql_last_value
ORDER BY tci.update_time