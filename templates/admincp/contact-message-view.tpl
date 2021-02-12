{include file="/admincp/header.tpl" nocache}
<div class="container-fluid">
    <div class="row">
        <div class="col-lg-12 m-top-20">
            <h4 class="messages-head">Service Messages</h5>
            <table class="table table-bordered table-hover">
              <tbody class="text-left" style="text-align: left!important">
                <tr>
                  <td class="text-left"><b>ID : {$messages.id}</b></td>
                </tr>
                <tr>
                  <td class="text-left"><b>Name : {$messages.first_name} {$messages.last_name}</b></td>
                </tr>
                <tr>
                  <td class="text-left"><b>Email-ID : {$messages.email}</b></td>
                </tr>
                <tr>
                  <td class="text-left"><b>Phone : {$messages.phone}</b></td>
                </tr>
                <tr>
                  <td class="text-left">
                    <b>Type : {if $messages.type == "extraction_services"}Extraction Services{/if}
                              {if $messages.type == "contract_manufacturing"}Contract Manufacturing{/if}
                              {if $messages.type == "distribution"}Distribution{/if}
                              {if $messages.type == "storage"}Storage{/if}
                              {if $messages.type == "lab_testing"}Lab Testing{/if}
                              {if $messages.type == "marketing_support"}Marketing Support{/if}
                              {if $messages.type == "sales_support"}Sales Support{/if}
                              {if $messages.type == "packaging"}Packaging{/if}
                              {if $messages.type == "labeling_and_finishing"}Labeling and Finishing{/if}
                              {if $messages.type == "cash_management"}Cash Management{/if} 
                              {if $messages.type == "other"}Other{/if}</b>
                  </td>
                </tr>
                <tr>
                  <td class="text-left"><b>Subject : {$messages.subject}</b></td>
                </tr>
                <tr>
                  <td class="text-left"><b> Message : </b><br /> {$messages.message}
                </tr>
                <tr>
                  <td class="text-right"><br /> {$messages.date_add}
                </tr> 
              </tbody>
            </table>
        </div>
    </div>
</div>
<!-- /.row -->
</div>
{include file="/admincp/footer.tpl" nocache}