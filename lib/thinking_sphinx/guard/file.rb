class ThinkingSphinx::Guard::File
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def lock
    ThinkingSphinx::Logger.log :guard, "Locking #{name} [pid #{Process.pid}]"
    FileUtils.touch path
  end

  def locked?
    File.exists? path
  end

  def path
    @path ||= File.join(
      ThinkingSphinx::Configuration.instance.indices_location,
      "ts-#{name}.tmp"
    )
  end

  def unlock
    ThinkingSphinx::Logger.log :guard, "Unlocking #{name} [pid #{Process.pid}]"
    FileUtils.rm path
  end
end
