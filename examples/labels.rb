require 'dbscan'

input = [ 0, 10, 20 ],
	[ 0, 11, 21 ],
	[ 0, 12, 20 ],
	[ 20, 33, 59 ],
	[ 21, 32, 56 ],
	[ 59, 77, 101 ],
	[ 58, 79, 100 ],
	[ 58, 76, 102 ],
	[ 300, 70, 20 ],
	[ 500, 300, 202],
	[ 500, 302, 204 ]

dbscan = DBSCAN( input,
                 :epsilon => 4,
                 :min_points => 1,
                 :distance => :euclidean_distance,
                 :labels => ['a', 'b', 'c', 'd', 'e', 'f','g', 'h', 'i', 'j', 'k'] )

dbscan.clusters.each do |cluster_id, points|
  puts "Cluster #{cluster_id}"
  points.each do |point|
    p point
  end
  puts
end
