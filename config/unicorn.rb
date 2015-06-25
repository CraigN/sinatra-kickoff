rack_env = ENV['RACK_ENV'] || 'production'
 
worker_processes (rack_env == 'production' ? 16 : 4)

preload_app true

timeout 30