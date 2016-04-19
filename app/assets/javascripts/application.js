// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require angular
//= require angular-animate
//= require angular-aria
//= require angular-messages
//= require angular-material

angular.module('cartopia', ['ngMaterial'])
.controller('AppCtrl', function($scope) {
	$scope.toggleRemember = function () {
		if ($("input[name='session[remember_me]']").val() == '1') {
			$("input[name='session[remember_me]']").val("0"); 
		} else {
			$("input[name='session[remember_me]']").val("1"); 
		}
	};
	$scope.clickLogin = function () {
		$("input[name='commit']").click();
	};
	$scope.clickSignup = function () {
		$("input[name='commit']").click();
	};
	$scope.yearSelected = function () {
		$("input[name='car[year]']").val($scope.year+"");
	};
	$scope.makeSelected = function () {
		$("input[name='car[make]']").val($scope.make+"");
	};
	$scope.stateSelected = function () {
		$("input[name='car[state]']").val($scope.state+"");
	};
});

$(document).on('ready page:load', function(arguments) {
	angular.bootstrap(document.body, ['cartopia'])
});

