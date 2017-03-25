

Pod::Spec.new do |s|


  s.name         = "FormConstructor"
  s.version      = "1.0.0"
  s.summary      = "FormConstructor framework"
  s.description  = "FormConstructor framework"
  s.homepage     = "http://EXAMPLE/FormConstructor"
  s.license      = "FormConstructor"
  s.author       = { "Ivankov Alexey" => "" }
  s.module_name = 'FormConstructor'

	s.ios.deployment_target = "8.0"
	s.osx.deployment_target = "10.7"
	s.watchos.deployment_target = "2.0"
	s.tvos.deployment_target = "9.0"


  s.source       = { :git => 'https://github.com/alexeyIvankov/FormConstructor.git', :branch => 'master', :submodules => true }

  s.source_files  = "TableContainer/TableContainer/**/*.{swift}", "FormConstructor/**/*.{swift}"
 

end
