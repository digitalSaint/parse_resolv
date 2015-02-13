class Resolv
macro
  IP (([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])
  HOST (([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9])
  SPACE \s+
rule
  ^(domain){SPACE}{HOST}$ { puts [:domain, text] }
  ^(search){SPACE}{HOST}$ { puts [:search, text] }
  ^(nameserver){SPACE}{IP}$ { nameservers = text.split(" "); puts Hash[nameservers.each_slice(2).to_a] }
  ^(options){SPACE}.*$ { puts [:options, text] }
  ^(\s*#.*|#.*)$
  {SPACE}
inner
  require 'json'
  def tokenize(line)
    scan_setup(line)
    tokens = []
    while token = next_token
      tokens << token
    end
    tokens
  end
end
