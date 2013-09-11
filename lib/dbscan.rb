## https://github.com/shiguodong/dbscan (fork)

require 'distance_measures'

require 'geocoder'

class Array
	def haversine_distance2(n)
		return Geocoder::Calculations::distance_between( self, n )
	end
end

module DBSCAN

	class Clusterer
		attr_accessor :points, :options, :clusters

		def initialize( points, options = {} )
			options[:distance] = :euclidean_distance if !options[:distance]
			options[:labels] = [] if !options[:labels]

			c = 0
			@points, @options, @clusters = points.map { |e| po = Point.new(e, options[:labels][c] ); c +=1; po }, options, {-1 => []}

			clusterize!
		end

		def clusterize!
			current_cluster = -1
			@points.each do |point|
				if !point.visited?
					point.visit!
					neighbors = inmediate_neighbors( point )
					if neighbors.size >= options[:min_points]
						current_cluster += 1
						point.cluster = current_cluster
						cluster = [point].push( add_connected( neighbors, current_cluster ))
						clusters[current_cluster] = cluster.flatten
					else
						clusters[-1].push( point )
					end
				end
			end

		end

		def results
			hash = {}
			@clusters.dup.each { |cluster_index, value| hash[cluster_index] = value.flatten.map(&:items) if !value.flatten.empty? }
			hash
		end

 		def labeled_results
 			hash = {}
 			@clusters.each do |cluster_index, elements|
 				hash.store( cluster_index, [] )
 				elements.each do |e|
 					hash[cluster_index].push( e.label )
 				end
 			end
			hash
		end

		def inmediate_neighbors( point )
			neighbors = []
			@points.each do |p|
				if p.items != point.items
					d = eval("point.items.#{options[:distance]}( p.items )")
					neighbors.push( p ) if d < options[:epsilon]
				end
			end
			neighbors
		end

		def add_connected( neighbors, current_cluster )
			cluster_points = []
			neighbors.each do |point|
				if !point.visited?
					point.visit!
					new_points = inmediate_neighbors(point)

					if new_points.size >= options[:min_points]
						new_points.each do |p|
							if !neighbors.include?(p)
								neighbors.push( p )
							end
						end
					end
				end

				if !point.cluster
					cluster_points.push( point )
					point.cluster = current_cluster
				end
			end

			cluster_points
		end
	end

	class Point
		attr_accessor :items, :cluster, :visited, :label
		define_method(:visited?) { @visited }
		define_method(:visit!) { @visited = true }
		def initialize( point, label )
			@items, @cluster, @visited, @label = point, nil, false, label
		end
	end

	def DBSCAN( * args )
		Clusterer.new( *args )
	end
end

include DBSCAN
