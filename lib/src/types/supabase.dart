/// Friendship status will use ints to represent the relationship between two
/// users. the higher the number the closer their relationship. 0 means blocked,
/// 1 is pending request, and 2 is an accepted friendship.
///
/// the friendship status will currently be stored in the database as an [int],
/// so always send the [FriendshipStatus]'s `value` property to the database,
/// and of course when requesting the status from the database you can simply
/// compare the return [int] with a [FriendshipStatus] without having to convert
/// the returnedn [int] into a [FriendshipStatus] object
class FriendshipStatus {
  final int value;
  const FriendshipStatus._(this.value);

  static FriendshipStatus get none => const FriendshipStatus._(-1);
  static FriendshipStatus get blocked => const FriendshipStatus._(0);
  static FriendshipStatus get pending => const FriendshipStatus._(1);
  static FriendshipStatus get accepted => const FriendshipStatus._(2);

  @override
  bool operator ==(Object other) {
    if (other is int) {
      return value == other;
    } else if (other is FriendshipStatus) {
      return value == other.value;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => super.hashCode;
}
