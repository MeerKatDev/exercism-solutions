object Flattener {
  fun flatten(source: List<Any?>): List<Any?> {
      return source.fold(listOf()) { x, hd ->
        when (hd) {
            is List<Any?> -> x + flatten(hd)
            is Int -> x + listOf(hd)
            else -> x
        }
      }
  }
}
