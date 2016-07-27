package ru.bmstu.rk9.rao.jvmmodel

import ru.bmstu.rk9.rao.rao.Sequence
import org.eclipse.xtext.xbase.jvmmodel.JvmTypesBuilder
import org.eclipse.xtext.xbase.jvmmodel.JvmTypeReferenceBuilder
import org.eclipse.xtext.common.types.JvmDeclaredType
import org.eclipse.xtext.common.types.JvmVisibility

class SequenceCompiler extends RaoEntityCompiler {
	def static asField(Sequence sequence, JvmTypesBuilder jvmTypesBuilder,
		JvmTypeReferenceBuilder typeReferenceBuilder, JvmDeclaredType it, boolean isPreIndexingPhase) {

		initializeCurrent(jvmTypesBuilder, null)

		return sequence.toField(sequence.name, sequence.constructor.inferredType) [
			visibility = JvmVisibility.PUBLIC
			static = true
		]
	}

	def static asInitializationMethod(Sequence sequence, JvmTypesBuilder jvmTypesBuilder,
		JvmTypeReferenceBuilder typeReferenceBuilder, JvmDeclaredType it, boolean isPreIndexingPhase) {

		initializeCurrent(jvmTypesBuilder, typeReferenceBuilder)

		return sequence.toMethod("initialize" + sequence.name.toFirstUpper, sequence.constructor.inferredType) [
			visibility = JvmVisibility.PRIVATE
			final = true
			static = true
			body = sequence.constructor
		]
	}
}
