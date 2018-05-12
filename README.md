## Parse resolv.conf into json or yaml

#### Create lexer.rb
```rex test_resolv.rex -o lexer.rb```

#### Parse file
```ruby resolv_parse.rb```

#### YAML output from sample resolv.conf file
```yaml
---
nameservers:
- 192.168.1.254
- 192.168.1.253
domain: local.tld
search:
- a.local.tld
- b.local.tld
- local.tld
options:
- rotate
- timeout:1
- attempts:2
```

#### JSON output from sample resolv.conf file
```json
{
  "nameservers": ["192.168.1.254","192.168.1.253"],
  "domain": "local.tld",
  "search": ["a.local.tld","b.local.tld","local.tld"],
  "options": ["rotate","timeout:1","attempts:2"]
}
```
#### Ruby hash output from sample resolv.conf file
```ruby
{
  :nameservers => ["192.168.1.254", "192.168.1.253"],
  :domain => "local.tld",
  :search => ["a.local.tld", "b.local.tld", "local.tld"],
  :options => ["rotate", "timeout:1", "attempts:2"]
}
```
