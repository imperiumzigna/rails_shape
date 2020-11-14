require "fileutils"

class ServiceGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../templates/services", __FILE__)
  desc <<-DESC.strip_heredoc
        TODO
  DESC

  class_option :module, aliases: "-m", type: :string, desc: "TODO"
  class_option :pattern, default: "service_caller", type: :string, desc: "TODO"
  def create_service
    @mod = options[:module]
    @pattern = options[:pattern]
    @name = file_name.underscore

    pattern_exist?

    service_dir_path = File.join("app", "services")
    service_dir_path = File.join(service_dir_path, @mod.underscore) if @mod.present?
    generator_path = File.join(service_dir_path, "#{@name}_service.rb")

    FileUtils.mkdir_p(service_dir_path)

    template "#{@pattern}.rb", generator_path
  end

  private
    def pattern_exist?
      file = find_in_source_paths("#{@pattern}.rb")

      !file.blank?
    rescue Thor::Error
      $stderr.puts "Pattern not supported! See the list for supported service design patterns:"
      exit 1
    end
end
