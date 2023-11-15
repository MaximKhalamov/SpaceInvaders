import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.function.Function;
import java.util.stream.Collectors;

class WavesManager {
  public final Map<EnemyStarship, Vector3> ships = new HashMap<>();
  private final PosGenerator posGenerator;

  public WavesManager(PosGenerator posGenerator) {
    this.posGenerator = posGenerator;
  }

  public void registerShips(EnemyStarship... ships) {
    Arrays.stream(ships)
      .forEach(ship -> registerShip(ship));
  }

  public void registerShip(EnemyStarship ship) {
    registerShip(ship, null);
  }

  public void registerShip(EnemyStarship ship, Vector3 position) {
    ships.put(ship, position);
  }

  public void init() {
    List<EnemyStarship> undefinedShips = this.ships
      .entrySet()
      .stream()
      .filter(shipEntry -> shipEntry.getValue() == null)
      .map(shipEntry -> shipEntry.getKey())
      .collect(Collectors.toUnmodifiableList());

    for (int i = 0; i < undefinedShips.size(); i++) {
      double normt = (double) i / undefinedShips.size() - 0.5;
      Vector3 generatedPosition = new Vector3(posGenerator.apply(normt));

      ships.put(undefinedShips.get(i), generatedPosition);
    }
  }

  public void update(Function<Entry<EnemyStarship, Vector3>, Vector3> posMutator) {
    for (var shipEntry : ships.entrySet()) {
      var newPostion = posMutator.apply(shipEntry);

      ships.put(shipEntry.getKey(), newPostion);
    }
  }
}
