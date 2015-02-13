require './lexer.rb'

class ResolvParser
  def parse(resolvconf)
    @scanner =  Resolv.new
    File.open(resolvconf, 'r') do |f|
      while line = f.gets
        @scanner.tokenize(line)
      end
    end
  end
end

rp = ResolvParser.new
rp.parse("/etc/resolv.conf")
