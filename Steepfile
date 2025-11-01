# Steep configuration for DailyVerseApi modular monolith
# Analyzes code under app/modules and signatures under sig/

# Type checking target for application code
target :app do
  # Source code to check
  check "app/modules"

  # Signatures
  signature "sig"

  # Use rbs_rails to provide Rails/ActiveRecord signatures
  library "rbs_rails"

  # Optional: tune type checking mode
  # This is a good starting point; tighten incrementally per context/slice if desired.
  configure_code_diagnostics strict: false
end
