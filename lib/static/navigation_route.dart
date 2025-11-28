enum NavigationRoute {
  mainRoute("/main"),
  detailRoute("/detail"),
  settingsRoute("/settings");

  const NavigationRoute(this.name);
  final String name;
}
