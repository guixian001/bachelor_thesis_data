---
# This file is for profiling an individual Kong extension.
# Duplicate this file in your own *publisher path* on your own branch.
# Your publisher path is relative to _app/_hub/.
# The path must consist only of alphanumeric characters and hyphens (-).
#
# The following YAML data must be filled out as prescribed by the comments
# on individual parameters. Also see documentation at:
# https://github.com/Kong/docs.konghq.com
# Remove inapplicable entries and superfluous comments as needed

name: Spherical Defense API protector # (required) The name of your extension.
  # Use capitals and spaces as needed.
publisher: Spherical Defense # (required) The name of the entity publishing this extension.
  # Use capitals and spaces as needed.
  # If you are an individual, you might choose to use your GitHub handle, or your name.
  # If this is being published and supported by a company, please use your company name.
  # Note that every extension by a given publisher must have the exact same value

categories: # (required) Uncomment all that apply.
  #- authentication
  - security
  #- traffic-control
  #- serverless
  #- analytics-monitoring
  #- transformations
  #- logging
  #- deployment
# Array format only; uncomment the one most-applicable category. Contact cooper@konghq.com to propose a new category, if necessary.

type: # (required) String, one of:
   plugin          | extensions of the core platform
  # integration     | extensions of the Kong Admin API

desc: Spherical Defense secures your Services and APIs with unsupervised deep learning. # (required) 1-liner description; max 80 chars
description: #|
  # (required) extended description.
  # Use YAML piple notation for extended entries.
  # EXAMPLE long text format (do not use this entry)
   description: |
     Spherical Defense is deployed on-premise or private cloud, with a simple 1-click deployment process on AWS, or through the Docker hub. 
     Security models can start detecting malicious behaviour within 4 hours and offer excellent support for zero-day attacks and the OWASP Top 10. 
     No manual configuration is needed. Ever. 

     Spherical Defense offers excellent protection in the following classes: 
     - Excessive Data Exposure
     - Malicious Injection (SQL, XSS, NoSQL, etc)
     - Improper Assets Management
     - Sensitive Information Transmission
     - Authorized Stateful Attacks
     - Mass Assignment
     - ML Attack Tools

support_url: https://sphericaldefence.com
  # Defaults to the url setting in your publisher profile.

#source_url:
  # (Optional) If your extension is open source, provide a link to your code.

#license_type:
  # (Optional) For open source, use the abbreviations in parentheses at:
  # https://opensource.org/licenses/alphabetical

#license_url:
  # (Optional) Link to your custom license.

#privacy_policy:
  # (Optional) If you have a custom privacy policy, place it here

#privacy_policy_url:
  # (Optional) Link to a remote privacy policy

#terms_of_service:
  # (Optional) Text describing your terms of service.

#terms_of_service_url:
  # (Optional) Link to your online TOS.

# COMPATIBILITY
# In the following sections, list Kong versions as array items.
# Versions are categorized by Kong edition and their known compatibility.
# Unlisted Kong versions will be considered to have "unknown" compatibility.
# Uncomment at least one of 'community_edition' or 'enterprise_edition'.
# Add array-formatted lists of versions under their appropriate subsection.

kong_version_compatibility: # required
  community_edition: # optional
    compatible:
    #incompatible:
  enterprise_edition: # optional
    compatible:
    #incompatible:

# EXAMPLE kong_version_compatibility blocks - these examples show how to indicate various compatibilities. Also see other extension files in _app/_hub/ for more examples
# EXAMPLE 1 - in this example, the extension is known to be compatible with recent versions of Kong and Kong Enterprise, and is not known to be incompatible with any versions
kong_version_compatibility:
  community_edition:
    compatible:
#      - 0.12.x
      - 0.13.x
      - 0.14.x
#    incompatible:
  enterprise_edition:
    compatible:
      - 0.32-x
      - 0.33-x
      - 0.34-x
#    incompatible:
#
# EXAMPLE 2 - in this example, the extension is known to be compatible only the most recent versions of Kong and Kong Enterprise, and is known to be incompatible with all older versions
#kong_version_compatibility:
#  community_edition:
#    compatible:
#      - 0.14.x
#      - 0.13.x
#    incompatible:
#      - 0.12.x
#      - 0.11.x
#      - 0.10.x
#      - 0.9.x
#      - 0.8.x
#      - 0.7.x
#      - 0.6.x
#      - 0.5.x
#      - 0.3.x
#      - 0.2.x
#  enterprise_edition:
#    compatible:
#      - 0.34-x
#      - 0.33-x
#      - 0.32-x
#    incompatible:
#      - 0.31-x
#      - 0.30-x
#      - 0.29-x

#########################
# PLUGIN-ONLY SETTINGS below this line
# If your extension is a plugin, ALL of the following lines must be completed.
# If NOT an plugin, delete all lines up to '# BEGIN MARKDOWN CONTENT'

params: # metadata about your plugin
  name: # name of the plugin in Kong (may differ from name: above)
  api_id: true
    # boolean - whether this plugin can be applied to an API [[this needs more]]
  service_id: true
    # boolean - whether this plugin can be applied to a Service.
    # Affects generation of examples and config table.
  consumer_id: false
    # boolean - whether this plugin can be applied to a Consumer.
    # Affects generation of examples and config table.
  route_id: true
    # whether this plugin can be applied to a Route.
    # Affects generation of examples and config table.
  protocols: ["http", "https"]
    # List of protocols this plugin is compatible with.
    # Valid values: "http", "https", "tcp", "tls"
    # Example: ["http", "https"]
  dbless_compatible: yes
    # Degree of compatibility with DB-less mode. Three values allowed:
    # 'yes', 'no' or 'partially'
  dbless_explanation: 
    # Optional free-text explanation, usually containing details about the degree of
    # compatibility with DB-less.

  config: # Configuration settings for your plugin
    - name: url
      required: yes
      value_in_examples: csic.darwin.sphericaldefence.com
        # If the field is to appear in examples, this is the value to use.
        # A required field with no value_in_examples entry will resort to
        # the one in default.
      description: This is the address of a running Spherical Defense instance. Must be either an API address, or a hostname.
        # Explain what this setting does.
        # Use YAML's pipe (|) notation for longer entries.
    - name: blocking
      required: yes
      value_in_examples: true
        # If the field is to appear in examples, this is the value to use.
        # A required field with no value_in_examples entry will resort to
        # the one in default.
      description: Whether inbound HTTP requests should be blocked if anomalous, or if they should only trigger a notification.
        # Explain what this setting does.
        # Use YAML's pipe (|) notation for longer entries.
    - name: timeout
      required: false
      value_in_examples: 10000
        # If the field is to appear in examples, this is the value to use.
        # A required field with no value_in_examples entry will resort to
        # the one in default.
      description: How long the plugin should wait until timing out.
        # Explain what this setting does.
        # Use YAML's pipe (|) notation for longer entries.
    - name: keepalive
      required: false
      value_in_examples: 60000
        # If the field is to appear in examples, this is the value to use.
        # A required field with no value_in_examples entry will resort to
        # the one in default.
      description: How long a connection to the Spherical backend should be maintained for.
        # Explain what this setting does.
        # Use YAML's pipe (|) notation for longer entries.
  #  - name: # add additional setting blocks as needed, each demarcated by -
  extra:
    # This is for additional remarks about your configuration.
###############################################################################
# END YAML DATA
# Beneath the next --- use Markdown (redcarpet flavor) and HTML formatting only.
#
# The remainder of this file is for free-form description, instruction, and
# reference matter.
# If you include headers, your headers MUST start at Level 2 (parsing to
# h2 tag in HTML). Heading Level 2 is represented by ## notation
# preceding the header text. Subsequent headings,
# if you choose to use them, must be properly nested (eg. heading level 2 may
# be followed by another heading level 2, or by heading level 3, but must NOT be
# followed by heading level 4)
###############################################################################
# BEGIN MARKDOWN CONTENT
---

## Your first heading will go here