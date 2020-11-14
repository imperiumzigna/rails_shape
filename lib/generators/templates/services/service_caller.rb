class <%= @mod.present? ? "#{@mod.camelize}::#{@name.camelize}": @name.camelize %>
  @@actions = [:action]

  def self.call(action, *args)
    raise ArgumentError.new("Action not found! Available actions: #{@@actions}") if @@actions.include?(action)

    new.call(action, args)
  end

  def call(action, *args)
    send(:action, args)
  end

  private

  def action
  end
end