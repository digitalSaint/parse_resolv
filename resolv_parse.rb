require './lexer.rb'

class ResolvParser
  def parse(resolvconf)
    @scanner =  Resolv.new
    @scanner.initialize_obj
    File.open(resolvconf, 'r') do |f|
      while line = f.gets
        @scanner.tokenize(line)
      end
    end
    puts @scanner.resolv_json
    puts @scanner.resolv_yaml
  end
end

rp = ResolvParser.new
rp.parse("./resolv.conf")
