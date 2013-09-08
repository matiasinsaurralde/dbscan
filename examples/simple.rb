require 'dbscan'

require 'pp'

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

dbscan = DBSCAN( input, :epsilon => 4, :min_points => 1, :distance => :euclidean_distance )

pp dbscan.results

