----------------------------------------------------------------


```
private List<CustomerType> mergeWithmyCustomerList(List<CustomerType> myCustomerList,
			List<CustomerType> elseCustomerList) {
		List<CustomerType> retval = Stream.concat(elseCustomerList.stream(), myCustomerList.stream()) //
				.filter(new ConcurrentSkipListSet<>(ComparatorCollection.COMPARATOR_CUSTOMER_TYPE_MERGE)::add)//
				.collect(Collectors.toList());
		
		return retval;
	}

```

----------------------------------------------------------------
```
List<CustomerType> myCustomerList = retval.map(ProfileType::getClientProfile)//
					.map(ClientProfileType::getRegulatoryInfo) //
					.map(RegulatoryInfoType::getCustomerInfo) //
					.map(CustomerTypeListType::getCustomerAccount) //
					.orElse(new ArrayList<>());
Collections.sort(myCustomerList, ComparatorCollection.COMPARATOR_CLIENT_Customer_TYPE_Customer_ID);

```
----------------------------------------------------------------

```
List<ProductType> elseProductCustomerList = party.profile.map(ProfileType::getClientProfile) //
								.map(ClientProfileType::getPersonalInfo) //
								.map(PersonalInfoType::getProducts) //
								.map(ProductListType::getProduct) //
								.orElse(new ArrayList<>()) //
								.stream() //
								.filter(o -> WealthServiceCoreConstants.PRODUCT_CODE_SAV.equals(o.getProductCode())) //
								.filter(o -> WealthServiceCoreConstants.else_ACCOUNT_STATUS_ACTIVE //
										.equalsIgnoreCase(
												o.getAccountStatus() == null ? null : o.getAccountStatus().value())) //
								.collect(Collectors.toList());

```


----------------------------------------------------------------

Objects.equals(oldValue, newValue);

----------------------------------------------------------------


