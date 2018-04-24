Pod::Spec.new do |spec|
  spec.name = 'NanoLog'
  spec.version = '0.1'
  spec.summary = 'Small and simple, yet powerful, logging for Swift'
  spec.description = <<-DESC
    NanoLog is a Swift framework, for easily adding logging to your apps.
    It is small, but powerful and offers an extensible API along with many
    customisations.

    It is easy-to-use; lightweight; extensible; offers multiple severity
    levels; provides coloured output; shows the context of your log calls;
    has a customisable log format and is fully documented.
  DESC
  spec.homepage = 'https://github.com/andrewlord1990/nanolog-swift'
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.author = { 'Andrew Lord' => 'andrewlord1990@gmail.com' }
  spec.social_media_url = 'https://twitter.com/@andrewlord1990'

  spec.ios.deployment_target = '8.0'
  spec.osx.deployment_target = '10.10'
  spec.watchos.deployment_target = '2.0'
  spec.tvos.deployment_target = '9.0'

  spec.source = { git: 'https://github.com/andrewlord1990/nanolog-swift.git', tag: "v"+spec.version.to_s }
  spec.source_files = 'Sources/**/*'

  spec.frameworks = 'Foundation'
end
