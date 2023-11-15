import java.util.function.Function;

@FunctionalInterface
interface CoordsMutator{
  Vector3 apply(Vector3 position);
}
