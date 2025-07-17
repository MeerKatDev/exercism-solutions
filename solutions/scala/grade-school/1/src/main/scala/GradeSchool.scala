import scala.collection.immutable.{Map, SortedMap}

class School {
  type DB = Map[Int, Seq[String]]

  var db: DB = SortedMap.empty

  def add(name: String, g: Int): Unit =
    db += (g -> (grade(g) :+ name))

  def grade(g: Int): Seq[String] = db.getOrElse(g, Seq())

  def sorted: DB = db.mapValues(_.sorted).toMap
}
