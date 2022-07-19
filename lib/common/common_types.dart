enum Path {
  login('/api/login/'),
  chat('/api/chat/'),
  room('/api/room/'),
  friends('/api/friends/');

  final String path;

  const Path(this.path);
}
