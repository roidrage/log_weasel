require 'active_support/buffered_logger'

class LogWeasel::BufferedLogger < ::ActiveSupport::BufferedLogger
  def add(severity, message = nil, progname = nil, &block)
    super(severity, "[#{DateTime.now.strftime('%Y-%m-%d %H:%M:%S')}] #{LogWeasel::Transaction.id} #$$ #{format_severity(severity)} #{message}", progname, &block)
  end

  private
  # Severity label for logging. (max 5 char)
  SEV_LABEL = %w(DEBUG INFO WARN ERROR FATAL ANY)

  def format_severity(severity)
    SEV_LABEL[severity] || 'ANY'
  end
end