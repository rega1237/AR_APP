# Be sure to restart your server when you modify this file.
Rack::Mime::MIME_TYPES['.usdz'] = 'model/vnd.usdz+zip'
Rack::Mime::MIME_TYPES['.glb'] = 'model/gltf-binary'
Mime::Type.register "model/vnd.usdz+zip", :usdz
Mime::Type.register "model/gltf-binary", :glb
