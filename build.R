# Make Documentation
roxygen2::roxygenise()

# Run the RCMD check
rcmdcheck::rcmdcheck(args = "--no-manual", error_on = "error")
