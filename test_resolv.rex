class Resolv
macro
  IP (([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])
  HOST (([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9])
  SPACE \s+
rule
  ^(domain){SPACE}{HOST}$ { @domain = text.split(" ")[1] }
  ^(search){SPACE}({HOST}{SPACE}?)+$ { @search = text.split(" ")[1..-1] }
  ^(nameserver){SPACE}{IP}$ { @nameservers << text.split(" ")[1] }
  ^(options){SPACE}.*$ { @options << text.split(" ")[1] }
  ^(\s*#.*|#.*)$
  {SPACE}
inner
  require 'json'
  require 'yaml'

  def initialize_obj
    @nameservers = Array.new
    @domain = ""
    @search = Array.new
    @options = Array.new
  end

  def tokenize(line)
    scan_setup(line)
    tokens = []
    while token = next_token
      tokens << token
    end
    tokens
  end

  def get_resolv
    resolv = Hash.new
    if !@nameservers.empty?
      resolv[:nameservers] = @nameservers
    end
    if !@domain.empty?
      resolv[:domain] = @domain
    end
    if !@search.empty?
      resolv[:search] = @search
    end
    if !@options.empty?
      resolv[:options] = @options
    end
    resolv
  end

  def resolv_yaml
    resolv = Hash.new
    get_resolv.each{|k,v| resolv[k.to_s] =v }
    resolv.to_yaml
  end

  def resolv_json
    get_resolv.to_json
  end
end
