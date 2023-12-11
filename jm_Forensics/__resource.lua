resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
lua54 'yes'

author 'justme1108'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
}

client_scripts {
	"lib/Tunnel.lua",
	"lib/Proxy.lua",
	'config.lua',
    'client.lua'
}

server_scripts {
	'@vrp/lib/utils.lua',
	'config.lua',
    'server.lua'
}
