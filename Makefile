webtest:
	flutter drive --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart -d web-server --debug 
mobiletest:
	flutter drive --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart -d RMX1971 --debug 
.PHONY: webtest mobiletest