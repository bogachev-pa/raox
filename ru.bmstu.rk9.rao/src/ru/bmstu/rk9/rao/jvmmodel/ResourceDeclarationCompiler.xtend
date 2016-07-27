package ru.bmstu.rk9.rao.jvmmodel

import org.eclipse.xtext.xbase.jvmmodel.JvmTypesBuilder
import org.eclipse.xtext.xbase.jvmmodel.JvmTypeReferenceBuilder
import org.eclipse.xtext.common.types.JvmDeclaredType
import ru.bmstu.rk9.rao.rao.ResourceDeclaration
import org.eclipse.xtext.common.types.JvmVisibility

import org.eclipse.xtext.naming.QualifiedName

class ResourceDeclarationCompiler extends RaoEntityCompiler {
	def static asInitializationMethod(ResourceDeclaration resource, JvmTypesBuilder jvmTypesBuilder,
		JvmTypeReferenceBuilder typeReferenceBuilder, JvmDeclaredType it, boolean isPreIndexingPhase) {

		initializeCurrent(jvmTypesBuilder, typeReferenceBuilder)

		return resource.toMethod("initialize" + resource.name.toFirstUpper, resource.constructor.inferredType) [
			visibility = JvmVisibility.PRIVATE
			final = true
			static = true
			body = resource.constructor
		]
	}

	def static asGetter(ResourceDeclaration resource, JvmTypesBuilder jvmTypesBuilder,
		JvmTypeReferenceBuilder typeReferenceBuilder, JvmDeclaredType it, boolean isPreIndexingPhase) {

		initializeCurrent(jvmTypesBuilder, typeReferenceBuilder)
		val resourceQualifiedName = QualifiedName.create(qualifiedName, resource.name)

		return resource.toMethod("get" + resource.name.toFirstUpper, resource.constructor.inferredType) [
			visibility = JvmVisibility.
				PUBLIC
			final = true
			static = true
			body = '''
				return («returnType.simpleName») ru.bmstu.rk9.rao.lib.simulator.CurrentSimulator.getModelState().getResource(
						«returnType.simpleName».class,
						"«resourceQualifiedName»");
			'''
		]
	}
}
