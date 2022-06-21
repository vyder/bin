#!/usr/bin/env ruby

require 'fileutils'
require 'slop'

opts = Slop.parse do |o|
    o.on '-h', '--help' do
        puts o
        exit
    end
end

TEMPLATE = <<EOF
#!/usr/bin/env ruby

require 'slop'

opts = Slop.parse do |o|
    # o.integer '-p', '--port',
    #           "The port to run the server on (default: 8000)",
    #            default: 8000
    o.on '-h', '--help' do
        puts o
        exit
    end
end

command = opts.arguments.shift

if command === "hello"
    puts "Hello, CLI."
else
    puts "\nERROR: Unknown command '\#{command}'\\n\\n"
    puts opts
    exit 1
end
EOF

command = opts.arguments.shift

if command === "new"
    new_tool_name = opts.arguments.first
    filename = File.expand_path(new_tool_name, "~/bin")
    puts "Creating #{filename}..."
    File.open(filename, "w+") { |f| f.write(TEMPLATE) }
    FileUtils.chmod "+x", filename
    puts "Done."
    exit(0)
else
    puts "\nERROR: Unknown command '#{command}'\n\n"
    puts opts
    exit 1
end
