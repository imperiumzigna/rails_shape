require "test_helper"

class ServiceGeneratorTest < Rails::Generators::TestCase
  tests ServiceGenerator
  destination File.expand_path("../../tmp", __FILE__)


  test "no services are created with no params" do
    capture(:stderr) { run_generator }
    assert_no_file "app/services/test.rb"
  end

  test "creates a service without namespace" do
    run_generator %w(service_name)
    assert_class_names("", "service_name")
  end

  test "creates a service with namespace" do
    run_generator %w(service_name -m nspace)
    assert_class_names("nspace", "service_name")
  end

  private
    def assert_class_names(mod, name, options = {})
      base_dir = File.join("app", "services")
      base_dir = File.join("app", "services", mod.underscore) if !mod.blank?

      scope_prefix = mod.blank? ? "" : (mod.camelize + "::")
      assert_file "#{base_dir}/#{name}_service.rb", /#{scope_prefix + name.camelize}/
    end
end
