object Flattener {
  fun flatten(source: List<Any?>): List<Any?> {
      return source.fold(listOf()) { x, hd ->
        when (hd) {
            is List<*> -> x + flatten(hd)
            else -> x + listOf(hd)
            null -> x
        }
      }
  }
}
