
MigrationErrors - Notes about them
==

- catch all errors in MigrationErrors and handle them later

MigrationError.all.map(&:message)




Issue 1: can't convert nil into String
--------------
MigrationError.all.select{|m|/t convert nil into String/.match(m.message)}

ids = MigrationError.all.select{|m|/t convert nil into String/.match(m.message)}.map(&:travis_id)
try = Build.find(ids).map{ |b| [b.config[:env],b.obfuscated_config[:env]] if b.config && b.config[:env]}

builds = Build.find(ids)
builds.map{|build |  Travis::Api.data(build, :for => 'webhook', :type => 'build/finished', :version => 'v1')}


looking into
<MigrationError id: 384, travis_id: 2791888, message: "Exception migrating build 2791888 can't convert nil...", stacktrace: nil, created_at: "2013-01-21 10:48:52", updated_at: "2013-01-21 10:48:52">

  SslKey Load (26.9ms)  SELECT "ssl_keys".* FROM "ssl_keys" WHERE "ssl_keys"."repository_id" = 226940 LIMIT 1
TypeError: can't convert nil into String
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/bundler/gems/travis-core-fab80d2a1bc4/lib/travis/model/ssl_key.rb:57:in `initialize'

root cause:
private_key in table ssl_keys doesn't exist for that repository

SELECT "ssl_keys".* FROM "ssl_keys" WHERE "ssl_keys"."repository_id" = 226940 LIMIT 1

zeile 57:
   def build_key
      @build_key ||= OpenSSL::PKey::RSA.new(private_key)
    end

- brauchen wir den private key überhaupt oder ist das nur für den
authentication token?

select count(*) from "ssl_keys" WHERE private_key IS NULL;
=> private_key ist immer null

gna. klar, die sind gelöscht!
aber warum tut es dann dennoch in den meisten fällen??



build.obfuscated_config geht schief
-> scheitert nur dort, wo keys in der config verschlüsselt werden müssen!


### Complete Stack Trace

1.9.3-p362 :068 >     json = Travis::Api.data(build, :for => 'webhook', :type => 'build/finished', :version => 'v1')
TypeError: can't convert nil into String
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/bundler/gems/travis-core-fab80d2a1bc4/lib/travis/model/ssl_key.rb:57:in `initialize'
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/bundler/gems/travis-core-fab80d2a1bc4/lib/travis/model/ssl_key.rb:57:in `new'
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/bundler/gems/travis-core-fab80d2a1bc4/lib/travis/model/ssl_key.rb:57:in `build_key'
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/bundler/gems/travis-core-fab80d2a1bc4/lib/travis/model/ssl_key.rb:25:in `decrypt'
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/bundler/gems/travis-core-fab80d2a1bc4/lib/travis/event/secure_config.rb:61:in `decrypt_value'
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/bundler/gems/travis-core-fab80d2a1bc4/lib/travis/event/secure_config.rb:40:in `decrypt_element'
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/bundler/gems/travis-core-fab80d2a1bc4/lib/travis/event/secure_config.rb:25:in `block in decrypt'
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/bundler/gems/travis-core-fab80d2a1bc4/lib/travis/event/secure_config.rb:23:in `each'
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/bundler/gems/travis-core-fab80d2a1bc4/lib/travis/event/secure_config.rb:23:in `inject'
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/bundler/gems/travis-core-fab80d2a1bc4/lib/travis/event/secure_config.rb:23:in `decrypt'
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/bundler/gems/travis-core-fab80d2a1bc4/lib/travis/model/env_helpers.rb:7:in `block in obfuscate_env'
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/bundler/gems/travis-core-fab80d2a1bc4/lib/travis/model/env_helpers.rb:6:in `map'
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/bundler/gems/travis-core-fab80d2a1bc4/lib/travis/model/env_helpers.rb:6:in `obfuscate_env'
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/bundler/gems/travis-core-fab80d2a1bc4/lib/travis/model/build.rb:164:in `block (2 levels) in obfuscated_config'
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/bundler/gems/travis-core-fab80d2a1bc4/lib/travis/model/build.rb:162:in `map'
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/bundler/gems/travis-core-fab80d2a1bc4/lib/travis/model/build.rb:162:in `block in obfuscated_config'
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/bundler/gems/travis-core-fab80d2a1bc4/lib/travis/model/build.rb:157:in `tap'
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/bundler/gems/travis-core-fab80d2a1bc4/lib/travis/model/build.rb:157:in `obfuscated_config'
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/bundler/gems/travis-core-fab80d2a1bc4/lib/travis/api/v1/webhook/build/finished.rb:16:in `data'
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/bundler/gems/travis-core-fab80d2a1bc4/lib/travis/api.rb:12:in `data'
  from (irb):68
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/gems/railties-3.2.9/lib/rails/commands/console.rb:47:in `start'

Idee: einfach ssl private key überschreiben um migration zu ermöglichen? aber warum klappt es bei den meisten? wo holen die den key her?
travis-core lokal holen:
gem "foo", :path => "/path/to/foo"


next step: debug through it to find decision why it works in most cases!

https://github.com/cldwalker/debugger

-> get them directly from travis ci!!!!!

geht so nicht direkt, da das format anders ist, zb. repository
eine referenz

aber brauchen wir das nicht ohnehin, wenn ggfs. fehlende builds nachgefordert werden müssen über die api?

--> erstmal in anderen fehler gucken





Issue 2: undefined method `key' for nil:NilClass
--------------
MigrationError.all.select{|m|/undefined method `key' for nil:NilClass/.match(m.message)}.size


### Stack Trace


NoMethodError: undefined method `key' for nil:NilClass
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/bundler/gems/travis-core-fab80d2a1bc4/lib/travis/model/env_helpers.rb:7:in `block in obfuscate_env'
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/bundler/gems/travis-core-fab80d2a1bc4/lib/travis/model/env_helpers.rb:6:in `map'
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/bundler/gems/travis-core-fab80d2a1bc4/lib/travis/model/env_helpers.rb:6:in `obfuscate_env'
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/bundler/gems/travis-core-fab80d2a1bc4/lib/travis/model/job.rb:90:in `block (2 levels) in obfuscated_config'
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/bundler/gems/travis-core-fab80d2a1bc4/lib/travis/model/job.rb:127:in `process_env'
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/bundler/gems/travis-core-fab80d2a1bc4/lib/travis/model/job.rb:90:in `block in obfuscated_config'
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/bundler/gems/travis-core-fab80d2a1bc4/lib/travis/model/job.rb:88:in `tap'
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/bundler/gems/travis-core-fab80d2a1bc4/lib/travis/model/job.rb:88:in `obfuscated_config'
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/bundler/gems/travis-core-fab80d2a1bc4/lib/travis/api/v1/webhook/build/finished/job.rb:25:in `data'
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/bundler/gems/travis-core-fab80d2a1bc4/lib/travis/api/v1/webhook/build/finished.rb:34:in `block in data'
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/gems/activerecord-3.2.9/lib/active_record/associations/collection_proxy.rb:89:in `map'
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/gems/activerecord-3.2.9/lib/active_record/associations/collection_proxy.rb:89:in `method_missing'
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/bundler/gems/travis-core-fab80d2a1bc4/lib/travis/api/v1/webhook/build/finished.rb:34:in `data'
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/bundler/gems/travis-core-fab80d2a1bc4/lib/travis/api.rb:12:in `data'
  from (irb):91
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/gems/railties-3.2.9/lib/rails/commands/console.rb:47:in `start'
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/gems/railties-3.2.9/lib/rails/commands/console.rb:8:in `start'
  from /Users/kleinen/.rvm/gems/ruby-1.9.3-p362/gems/railties-3.2.9/lib/rails/commands.rb:41:in `<top (required)>'

gna. same issue as 1. maybe just override this method?

module Travis
  module Model
    module EnvHelpers
      def obfuscate_env(vars)
        vars = [vars] unless vars.is_a?(Array)
        vars.compact.map do |var|
          repository.key.secure.decrypt(var) do |decrypted|
            Travis::Helpers.obfuscate_env_vars(decrypted)
          end
        end
      end
    end
  end
end



Build.find(VisualBuild.last(10).map(&:travis_id)).map{ |b| [b.config[:env],b.obfuscated_config[:env]] if b.config && b.config[:env]}.compact




Issue 3: Psych::SyntaxError in build id 2076541
-------------------
MigrationError.all.select{|m|/Psych::SyntaxError/.match(m.message)}


- pull request for

https://github.com/travis-ci/travis-core/pull/19/files
- catch Psych::SyntaxError
with link to Psych issue

- maybe give Psych issue a shot?


https://github.com/tenderlove/psych/issues/23

uncommenting the pull request in lib/travis/model/build.rb
enables the build to be loaded, but as the config is still a string the
migration fails nonetheless.

# as a string, this is a work around for now :(
#  def config
#    deserialized = self['config']
#    if deserialized.is_a?(String)
#      logger.warn "Attribute config isn't YAML. Current serialized attributes: #{Build.serialized_attributes}"
#      deserialized = YAML.load(deserialized)
#    end
#    deserialized
#  end


as it's just 4 builds, I'm going to skip this.

others
---------------
errors = [/Psych::SyntaxError/,/undefined method `key' for nil:NilClass/,/t convert nil into String/]
MigrationError.all.reject{|m| x = false;errors.each {|r| x |= r.match(m.message)};x }


