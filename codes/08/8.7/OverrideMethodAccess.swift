public class A {	private func methodA() {}}// 子类访问权限不得高于父类访问权限internal class B: A {	// 类B的方法的访问权限不得高于类B的访问权限	// 但重写的methodA的访问权限可以高于原有的methodA的访问权限	override internal func methodA() {}}