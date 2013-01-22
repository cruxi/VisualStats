module Travis
  module Model
    module EnvHelpers
      def obfuscate_env(vars)
        vars = [vars] unless vars.is_a?(Array)
        #puts "====obfuscate_env ======= #{vars}"

        result = vars.compact.map do |var|
         # puts "=== var #{var}"
          shortcircuit_decrypt(var) do |decrypted|
          #repository.key.secure.decrypt(var) do |decrypted|
          #  puts "=== decrypted #{decrypted}"
            Travis::Helpers.obfuscate_env_vars(decrypted)
          end
        end
        #puts "==== result #{result}"
        result
      end
    end
  end
end

def shortcircuit_decrypt(config)
  return config if config.is_a?(String)
  #puts "====== decrypt #{config}"
  config.inject(config.class.new) do |result, element|
     key, element = element if result.is_a?(Hash)
     #puts "===== key, element #{key}, #{element}"
     {"UNKNOWN" => ["secure"]}
  end
end



# load 'lib/tasks/travismigrate_overwrite.rb'
# Build.find(VisualBuild.last(100).map(&:travis_id)).map{ |b| [b.config[:env],b.obfuscated_config[:env]] if b.config && b.config[:env]}
# Build.find(ids).map{ |b| [b.config[:env],b.obfuscated_config[:env]] if b.config && b.config[:env]}
