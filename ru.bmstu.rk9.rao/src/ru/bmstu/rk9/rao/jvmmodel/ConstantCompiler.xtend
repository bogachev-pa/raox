package ru.bmstu.rk9.rao.jvmmodel

import ru.bmstu.rk9.rao.rao.Constant
import org.eclipse.xtext.xbase.jvmmodel.JvmTypesBuilder
import org.eclipse.xtext.xbase.jvmmodel.JvmTypeReferenceBuilder
import org.eclipse.xtext.common.types.JvmDeclaredType
import org.eclipse.xtext.common.types.JvmVisibility

class ConstantCompiler extends RaoEntityCompiler {
	def static asField(Constant constant, JvmTypesBuilder jvmTypesBuilder,
		JvmTypeReferenceBuilder typeReferenceBuilder, JvmDeclaredType it, boolean isPreIndexingPhase) {

		initializeCurrent(jvmTypesBuilder, null)

		return constant.toField(constant.name, constant.constructor.inferredType) [
			visibility = JvmVisibility.PUBLIC
			static = true
		]
	}

	def static asInitializationMethod(Constant constant, JvmTypesBuilder jvmTypesBuilder,
		JvmTypeReferenceBuilder typeReferenceBuilder, JvmDeclaredType it, boolean isPreIndexingPhase) {

		initializeCurrent(jvmTypesBuilder, typeReferenceBuilder)

		return constant.toMethod("initialize" + constant.name.toFirstUpper, constant.constructor.inferredType) [
			visibility = JvmVisibility.PRIVATE
			final = true
			static = true
			body = constant.constructor
		]
	}
}