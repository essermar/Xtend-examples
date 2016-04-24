package org.xtext.example.dsl.ui.refactoring.impl;

import org.eclipse.ltk.core.refactoring.RefactoringStatus;
import org.eclipse.xtext.ui.refactoring.impl.DefaultRenameStrategy;

@SuppressWarnings("restriction")
public class GreetDSLRenameStrategy extends DefaultRenameStrategy {

	@Override
	public RefactoringStatus validateNewName(String newName) {
		RefactoringStatus status = super.validateNewName(newName);
		if ("Bruno".equals(newName)) {
			status.addFatalError("Illegal name: " + newName);
		}
		return status;
	}

}
