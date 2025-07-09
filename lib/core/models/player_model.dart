class Player {
  final int id;
  final String name;
  final String position;
  final String status;

  Player({
    required this.id,
    required this.name,
    required this.position,
    required this.status,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      name: json['name'],
      position: json['position'],
      status: json['status'],
    );
  }
}

class PlayersData {
  final List<Player> players;

  PlayersData({required this.players});

  factory PlayersData.fromJson(Map<String, dynamic> json) {
    return PlayersData(
      players: (json['players'] as List)
          .map((playerJson) => Player.fromJson(playerJson))
          .toList(),
    );
  }
}
