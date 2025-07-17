object SpaceAge {
  def earthAge(ageSeconds: Double): Double = ageSeconds / 31557600D

  def onEarth(ageSeconds: Double): Double = earthAge(ageSeconds) / 1D
  def onMercury(ageSeconds: Double): Double = earthAge(ageSeconds) / 0.2408467
  def onVenus(ageSeconds: Double): Double = earthAge(ageSeconds) / 0.61519726
  def onMars(ageSeconds: Double): Double = earthAge(ageSeconds) / 1.8808158
  def onJupiter(ageSeconds: Double): Double = earthAge(ageSeconds) / 11.862615
  def onSaturn(ageSeconds: Double): Double = earthAge(ageSeconds) / 29.447498
  def onUranus(ageSeconds: Double): Double = earthAge(ageSeconds) / 84.016846
  def onNeptune(ageSeconds: Double): Double = earthAge(ageSeconds) / 164.79132
}
