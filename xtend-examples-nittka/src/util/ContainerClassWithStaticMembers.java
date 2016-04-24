package util;

/**
 * Dummy class for illustrating static access in Xtend
 * */
public class ContainerClassWithStaticMembers {

	public static final ContainerClassWithStaticMembers INSTANCE = new ContainerClassWithStaticMembers();
	public static final String CONSTANT = "This is a constant.";

	public static boolean isStaticMethod() {
		return true;
	}

	public static boolean isTheEmptyString(String string) {
		return (string != null && string.length() == 0);
	}

	public String getResult() {
		return "result";
	}

	public static class TheInnerClass {
		public String getResult() {
			return "innerResult";
		}
	}
}
