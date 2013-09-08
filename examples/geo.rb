require 'dbscan'

require 'pp'

input = File.read('geodata').split("\n").map { |ln| ln.split(', ').map { |c| c.to_f } }

dbscan = DBSCAN( input, :epsilon => 0.1, :min_points => 1, :distance => :haversine_distance2 )

pp dbscan.results
