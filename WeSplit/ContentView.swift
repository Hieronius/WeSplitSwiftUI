import SwiftUI

/// The main content view of the WeSplit app.
struct ContentView: View {

	// MARK: - Properties

	/// The check amount entered by the user.
	@State private var checkAmount = 0.0

	/// The number of people to split the check among.
	@State private var numberOfPeople = 2

	/// The selected tip percentage.
	@State private var tipPercentage = 20

	/// Indicates whether the amount text field is currently focused.
	@FocusState private var amountIsFocused: Bool

	/// Calculates the total amount per person based on the check amount, tip percentage, and number of people.
	var totalPerPerson: Double {
		let peopleCount = Double(numberOfPeople + 2)
		let tipSelection = Double(tipPercentage)

		let tipValue = checkAmount / 100 * tipSelection
		let grandTotal = checkAmount + tipValue
		let amountPerPerson = grandTotal / peopleCount
 
		return amountPerPerson
	}

	/// Calculates total amount by including the tip
	var totalWithTip: Double {
		let tipSelection = Double(tipPercentage)
		let tipValue = checkAmount / 100 * tipSelection

		let totalAmount = checkAmount + tipValue

		return totalAmount

	}

	// MARK: - View

	var body: some View {
		NavigationStack {
			Form {
				Section {

					// The text field for entering the check amount.

					TextField("Amount",
							  value: $checkAmount,
							  format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
					.keyboardType(.decimalPad)
					.focused($amountIsFocused)

					// The picker for selecting the number of people.

					Picker("Number of people",
						   selection: $numberOfPeople) {
						ForEach(2..<100) {
							Text("\($0) people")
						}
					}
				}


				Section("How much tip do you want to leave?") {

					// The picker for selecting the tip percentage.

					Picker("Tip percentage",
						   selection: $tipPercentage) {
						ForEach(1..<101) {
							Text($0, format: .percent)
						}
					}
						   .pickerStyle(MenuPickerStyle())
				}

				Section("Amount per person") {

					// The text view displaying the total amount per person.

					Text(totalPerPerson,
						 format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
				}

				Section("Total amount") {

					// The text view displaying the total amount with tip

					Text(totalWithTip,
						 format: .currency(code: Locale.current.currency?.identifier ?? "USD"))

				}
			}
			.navigationTitle("WeSplit")
			.toolbar {
				ToolbarItemGroup(placement: .navigationBarTrailing) {
					if amountIsFocused {

						// The "Done" button that dismisses the keyboard.

						Button("Done") {
							amountIsFocused = false
						}
					}
				}
			}
		}
	}
}

#Preview {
	ContentView()
}
