Gem::Specification.new do |gem|
	gem.authors = ['Matias Insaurralde', 'shiguodong']
	gem.email = ['matiasbaruchinsaurralde@gmail.com', 'oreatial@gmail.com']
	gem.name = 'dbscan'
	gem.version = '0.1'
	gem.summary = 'DBSCAN implementation.'
	gem.description = 'DBSCAN (Density-based spatial clustering of applications with noise) is a data clustering algorithm proposed by Martin Ester, Hans-Peter Kriegel, Jorg Sander and Xiaowei Xu.'
	gem.homepage = 'https://github.com/matiasinsaurralde/dbscan'
	gem.files = ['lib/dbscan.rb']
	gem.add_runtime_dependency 'distance_measures'
	gem.add_runtime_dependency 'geocoder'
end
