{include file="common/header-1.tpl" nocache} 
		
		{include file="common/dashboard-navigation.tpl" nocache}
    <div class="container-fluid grey-bg xs-pdlr">
        <div class="container dashboard-con m50">
	{if $message != ''}<div class="alert alert-success m-top-10">{$message}</div>{/if}
	<form id="contactform" action="{$config.url}/index/contact" data-parsley-validate method="post">	

		<div class="col-md-12" style="margin-top:2%;">
			<div class="col-md-2">{$phrase.first_name}</div>
			<div class="col-md-6"><input class="form-control" name="first_name" data-parsley-required tabindex="1"></div>
		</div>
		<div class="col-md-12" style="margin-top:2%;">
			<div class="col-md-2">{$phrase.last_name}</div>
			<div class="col-md-6"><input class="form-control"  name="last_name" data-parsley-required tabindex="2"></div>
		</div>
		<div class="col-md-12" style="margin-top:2%;">
			<div class="col-md-2">Email Address</div>
			<div class="col-md-6">
			<input data-parsley-trigger="change focusout" class="form-control" type="email" id="email" name="email" data-parsley-required-message="Please enter Email ID" class="form-control" data-required="true" data-parsley-required tabindex="3"/>
                        </div>
				<!-- <input class="form-control" name="email" data-parsley-required tabindex="3"> -->
			</div>
		<div class="col-md-12" style="margin-top:2%;">
			<div class="col-md-2">Contact Number</div>
			<div class="col-md-6">
				<!-- <input class="form-control" name="phone" data-parsley-required tabindex="4"> -->
				 <input class="form-control" data-parsley-trigger="change focusout"  type="text" id="phone" data-mask="000-000-0000" name="phone"  data-parsley-minlength="12"  max-length='12' data-parsley-minlength-message="Enter the 10 digit phone number" data-parsley-required-message="Please enter Phone Number" class="form-control" data-required="true" data-parsley-required data-parsley-group="block1" tabindex="4"/>

			</div>
		</div>
		<div class="col-md-12" style="margin-top:2%;">
			<div class="col-md-2">Type</div>
			<div class="col-md-6">
				<select class="form-control" name="type" data-parsley-required>
					<option {if $ctype == "extraction_services"} selected {/if} value="extraction_services">Extraction Services</option>
					<option {if $ctype == "contract_manufacturing"} selected {/if} value="contract_manufacturing">Contract Manufacturing </option>
					<option {if $ctype == "distribution"} selected {/if} value="distribution">Distribution</option>
					<option {if $ctype == "storage"} selected {/if} value="storage">Storage</option>
					<option {if $ctype == "lab_testing"} selected {/if} value="lab_testing">Lab Testing</option>
					<option {if $ctype == "marketing_support"} selected {/if} value="marketing_support">Marketing Support</option>
					<option {if $ctype == "sales_support"} selected {/if} value="sales_support">Sales Support</option>
					<option {if $ctype == "packaging"} selected {/if} value="packaging">Packaging</option>
					<option {if $ctype == "labeling_and_finishing"} selected {/if} value="labeling_and_finishing">Labeling and Finishing</option>
					<option {if $ctype == "cash_management"} selected {/if} value="cash_management">Cash Management</option>
					<option {if $ctype == "other"} selected {/if} value="other" {if $ctype == ""} selected {/if}>Other</option>
				</select>
			</div>
		</div>
		<div class="col-md-12" style="margin-top:2%;">
			<div class="col-md-2">{$phrase.subject}</div>
			<div class="col-md-6"><input class="form-control" name="subject" data-parsley-required tabindex="5"></div>
		</div>
		<div class="col-md-12" style="margin-top:2%;">
			<div class="col-md-2">{$phrase.message}</div>
			<div class="col-md-6"><textarea class="form-control" rows="6" name="message" data-parsley-required tabindex="6"></textarea></div>
		</div>
		<div class="col-md-12" style="margin-top:2%; margin-bottom:2%;">
			<div class="col-md-2"></div>
			<div class="col-md-6"><input class="btn btn-success" value="Send" type="submit"  tabindex="7"/></div>
		</div>
	
</form>		

</div>
</div>
	{include file="common/footer-1.tpl" nocache}
	<!--script type="text/javascript">
    $(function()
    {
     $('.container').addClass('contact_us');
    });
	</script-->