var selectedTab;
var pupilID;
var tableName, query, whereclause, columnsData, selectedValue;
var allValues= new Array(), colname = new Array() ; // column array for jqgrid
var tablePk,isNonEditable = false, lastSelection = -1;
var  cols, valuesFroCell, gridRowsData, sortname, canAdd = true; // original column array from server


jQuery(document).ready(function() {	
	if(typeof page != 'undefined'  && page === "tbl_staff"){
		tableName =  "tbl_staff";			    	
    	whereclause = " WHERE (table_name = 'tbl_staff'); ";	
	}else{
		$(".yearsets").hide();
		selectedTab = "tbl_reg_types";
		tableName =  "tbl_reg_types";
		whereclause = " WHERE (table_name = 'tbl_reg_types'); ";
	}

	
	query = "SELECT COLUMN_NAME, COLUMN_COMMENT, TABLE_NAME, DATA_TYPE, COLUMN_KEY ,EXTRA FROM information_schema.columns ";
	reCreateTable();
	getGeneralGrid();

	
	$('#ulTabs').on('click', 'a', function(e) {
	    //e.preventDefault();
		selectedTab = this.parentElement.id; 
		setInfoMsg(null, false, null);
		$("#yearParamsDiv").hide();
		
			switch (this.parentElement.id) {
			    case "tbl_reg_types":
			    	tableName =  "tbl_reg_types";			    	
			    	whereclause = " WHERE (table_name = 'tbl_reg_types'); ";			    	
			    	reCreateTable();
			    	getGeneralGrid();
			        break;
			    case "tbl_food_type":
			    	tableName =  "tbl_food_type";			    	
			    	whereclause = " WHERE (table_name = 'tbl_food_type'); ";
			    	reCreateTable();
			    	getGeneralGrid();
			        break;
			    case "tbl_family_relation":
			    	tableName =  "tbl_family_relation";			    	
			    	whereclause = " WHERE (table_name = 'tbl_family_relation'); ";
			    	reCreateTable();
			    	getGeneralGrid();
			        break;
			    case "tbl_job_type":
			    	tableName =  "tbl_job_type";
			    	whereclause = " WHERE (table_name = 'tbl_job_type'); ";
			    	reCreateTable();
			    	getGeneralGrid();
			        break;
			    case "tbl_payment_type":
			    	tableName =  "tbl_payment_type";
			    	whereclause = " WHERE (table_name = 'tbl_payment_type'); ";
			    	reCreateTable();
			    	getGeneralGrid();
			        break;	
			    case "tbl_moadonit_groups":
			    	tableName =  "tbl_moadonit_groups";
			    	whereclause = " WHERE (table_name = 'tbl_moadonit_groups'); ";
			    	reCreateTable();
			    	getGeneralGrid();
			    	break;
			    case "tbl_school_years":
			    	tableName =  "tbl_school_years";
			    	whereclause = " WHERE (table_name = 'tbl_school_years'); ";
			    	$("#yearParamsDiv").show();
			    	reCreateTable();
			    	getGeneralGrid();
			    	break;
			    case "tbl_general_parameters":
			    	tableName =  "tbl_general_parameters";
			    	whereclause = " WHERE (table_name = 'tbl_general_parameters'); ";
			    	reCreateTable();
			    	getGeneralGrid();
			    	break;	
			    case "tbl_grade_code":
			    	tableName =  "tbl_grade_code";
			    	whereclause = " WHERE (table_name = 'tbl_grade_code'); ";
			    	reCreateTable();
			    	getGeneralGrid();
			    	break;	
			    case "tbl_grade_in_year":
			    	tableName =  "tbl_grade_in_year";
			    	whereclause = " WHERE (table_name = 'tbl_grade_in_year'); ";
			    	reCreateTable();
			    	getGeneralGrid();
			    	break;	
			    case "tbl_reg_source":
			    	tableName =  "tbl_reg_source";
			    	whereclause = " WHERE (table_name = 'tbl_reg_source'); ";
			    	reCreateTable();
			    	getGeneralGrid();
			    	break;
			    case "tbl_activity":
			    	tableName =  "tbl_activity";
			    	whereclause = " WHERE (table_name = 'tbl_activity'); ";
			    	sortname = "activityName";
			    	reCreateTable();
			    	getGeneralGrid();
			    	break;
			    case "tbl_course_type":
			    	tableName =  "tbl_course_type";
			    	whereclause = " WHERE (table_name = 'tbl_course_type'); ";
			    	reCreateTable();
			    	getGeneralGrid();
			    	break;
			}
			
			
	    	
	    	
	});
	
});

function prepareYearsForm(){
	$.ajax({
  		async: false,
		type: 'GET',
		datatype: 'jsonp',
        url: "LogisticsController",
        
        data: { 
        	action : "getRegDaysParam",
        	  },
        	
        success: function(data) {
        	if(data != undefined){
        		var selectYear = $("#currYear");
        		selectYear.empty();
        		for (var int = 0; int < gridRowsData.rows.length; int++) {
	            	selectYear.append($("<option></option>")
		                    .attr("value",gridRowsData.rows[int].yearID)
		                    .text(gridRowsData.rows[int].yearName)).val(data.currYear);
	            	
				}
        	
        		$("#regDays").val(data.regDays);
    				
    		}
        },
        error: function(e) {
        	result = false;
        	console.log(e);
		        	bootbox.alert("שגיאה בשמירת הנתונים, נא בדוק את הערכים ונסה שוב.", function() {	   	        		 
		        	});			
        }
        
      }); 
}

function saveRegDaysParam(){
	$.ajax({
  		async: false,
		type: 'POST',
		datatype: 'jsonp',
        url: "LogisticsController",
        
        data: { 
        	action : "saveRegDaysParam",
        	yearID : $("#currYear").val(),
        	daysToReg : $("#regDays").val()
        	  },
        	
        success: function(data) {
        	if (typeof data != "undefined") {
        		if(typeof data.status != "undefined"  && data.status == 1){
        			/* alert(data); */
        			if(typeof currentYearObject != "undefined"  ){
        				currentYearObject = data.result;
        				var yearDiv = $("#yearTag > span");
        				if(yearDiv.length > 0){
        						yearDiv.html(currentYearObject.yearName);
        				}
                		bootbox.alert(data.msg, function() {	   	        		 
        	        	});
        			}        		
        		}
					
			}
        },
        error: function(e) {
        	console.log(e);
		        	bootbox.alert("שגיאה בשמירת הנתונים, נא בדוק את הערכים ונסה שוב.", function() {	   	        		 
		        	});			
        }
        
      }); 
}

function yearsetsMenu(){
	$("#menu2").removeClass("active");
	$("#menu1").addClass("active");
	$(".yearsets").show();
	$(".prosets").hide();
	
	$( "#tbl_school_years > a" ).trigger( "click" );
	/*tableName =  "tbl_school_years";
	whereclause = " WHERE (table_name = 'tbl_school_years'); ";
	$("#yearParamsDiv").show();
	reCreateTable();
	getGeneralGrid();*/
}

function prosetsMenu(){
	$("#menu1").removeClass("active");
	$("#menu2").addClass("active");
	$(".prosets").show();
	$(".yearsets").hide();
	$( "#tbl_reg_types > a" ).trigger( "click" );
	/*$("#yearParamsDiv").hide();
	selectedTab = "tbl_reg_types";
	tableName =  "tbl_reg_types";
	whereclause = " WHERE (table_name = 'tbl_reg_types'); ";
	reCreateTable();
	getGeneralGrid();*/
}

function reCreateTable(){
	
	var container = $("#tableContainer"); 
	container.empty();
	var table = $("<table/>").attr('id','list').addClass('table table-bordered table-hover ').append("<tr><td></td></tr>");;
	container.append(table);
	var pager = $("<div/>").attr('id','pager');
	container.append(pager);
	return container;
}

/*var editSettings = {
        //recreateForm: true,
        jqModal: false,
        reloadAfterSubmit: true,
        closeOnEscape: true,
        savekey: [true, 13],
        closeAfterEdit: true,
        onclickSubmit: onclickSubmitLocal
    },
    addSettings = {
        //recreateForm: true,
        jqModal: false,
        reloadAfterSubmit: false,
        savekey: [true, 13],
        closeOnEscape: true,
        closeAfterAdd: true,
        onclickSubmit: onclickSubmitLocal
    },
    delSettings = {
        // because I use "local" data I don't want to send the changes to the server
        // so I use "processing:true" setting and delete the row manually in onclickSubmit
        onclickSubmit: function (options, rowid) {
            var $this = $(this), id = $.jgrid.jqID(this.id), p = this.p,
                newPage = p.page;

            // reset the value of processing option to true to
            // skip the ajax request to "clientArray".
            options.processing = true;

            // delete the row
            $this.jqGrid("delRowData", rowid);
            if (p.treeGrid) {
                $this.jqGrid("delTreeNode", rowid);
            } else {
                $this.jqGrid("delRowData", rowid);
            }
            $.jgrid.hideModal("#delmod" + id, {
                gb: "#gbox_" + id,
                jqm: options.jqModal,
                onClose: options.onClose
            });

            if (p.lastpage > 1) {// on the multipage grid reload the grid
                if (p.reccount === 0 && newPage === p.lastpage) {
                    // if after deliting there are no rows on the current page
                    // which is the last page of the grid
                    newPage--; // go to the previous page
                }
                // reload grid to make the row from the next page visable.
                $this.trigger("reloadGrid", [{page: newPage}]);
            }

            return true;
        },
        processing: true
    };*/

var mydata = {}, existingProperties = {},
floatTemplate = {formatter: 'number', sorttype: 'int'},
integerTemplate = {formatter: 'integer', sorttype: 'int'},
colorpickerTemplate = {
		/*stype: "color",*/
		/*edittype: "color",*/
	    searchoptions: {
	        dataInit: function (el) {
	           /* var self = this;
	            $(el).colorpicker();
	            $(el).colorpicker().on('changeColor', function(e) {
	            	console.log(self);
	                //do things when color is changed
	            });*/
	        }
	    },
	    editoptions: {
	        dataInit: function (el) {
	            var self = this , x, y ;
	            el.type = "color";
	            /*$(el).colorpicker();
	           
	            $(el).colorpicker().on('changeColor', function(e) {
	            	console.log(self);
	                //do things when color is changed
	            });
	            
	            $(el).colorpicker().on('showPicker', function(e) {
	            	console.log(self);
	            	var rectObject  = e.currentTarget.getBoundingClientRect();
	            	var d = $(".colorpicker.dropdown-menu");
	            	//d.css({top: rectObject.top, left: rectObject.left, position:'absolute'});
	                //do things when color is changed
	            });*/
	        }
	        //readonly: 'readonly'
	    },
	    formatter : function (cellValue, opts, rwd) {								
			if (cellValue) {
				return cellValue;
			} else {
				return '';
			}
		}
	},
dateTemplate = {
    editable: true,
    
    searchoptions: {
        dataInit: function (el) {
            var self = this;
           
            /*$(el).datepicker({
                dateFormat: 'dd/mm/yy', maxDate: 0, changeMonth: true, changeYear: true,
                onSelect: function (dateText, inst) {
                    setTimeout(function () {
                        self.triggerToolbar();
                    }, 50);
                }
            });*/
            
            $(el).datepicker({
			    format: "dd/mm/yyyy",
			    language: "he" ,
			    startDate: "today",
			    maxViewMode: 0,
			    minViewMode: 0,
			    todayBtn: true,
			    keyboardNavigation: false,
			    daysOfWeekDisabled: "5,6",
			    todayHighlight: true,
			    toggleActive: true ,
			    onSelect: function (dateText, inst) {

                }
			});
        }
    },
    editoptions: {
        dataInit: function (el) {
        	$(el).datepicker({
			    format: "dd/mm/yyyy",
			    language: "he" ,
			    startDate: "today",
			    maxViewMode: 0,
			    minViewMode: 0,
			    todayBtn: true,
			    keyboardNavigation: false,
			    daysOfWeekDisabled: "5,6",
			    todayHighlight: true,
			    toggleActive: true ,
			    onSelect: function (dateText, inst) {
                    setTimeout(function () {
                        self.triggerToolbar();
                    }, 50);
                }
			});
        }
        //readonly: 'readonly'
    },
    formatter : function (cellValue, opts, rwd) {								
		if (cellValue) {
			 getDateFromValue(cellValue);
			
			var d = $.fn.fmatter.call(this, "date",
					getDateFromValue(cellValue), opts, rwd);
			return d;
		} else {
			return '';
		}
	}
    , formatoptions: { newformat: "d/m/Y" }
},
phoneTemplate = {
	    editable: true,
	    editrules: { custom :true , custom_func: validatePhone}
},
dropdownTemplate = {
    edittype: "select",
    editable: true,
    stype: "select"
},
timeTemplate = {
	    editable: true,
	    searchoptions: { 
      	  dataInit: function (element) {
      		
                $(element).timepicker({
				    
				    closeOnWindowScroll : true,
				    disableTextInput: true,
				    step: 15,
				    timeFormat : 'H:i',
				    maxTime : '17:00',
				    minTime : '12:30'
				});
                
                
            } 
      	  
        },
	    editoptions: {
	        dataInit: function (element) {
	        	 $(element).timepicker({
					    
					    closeOnWindowScroll : true,
					    disableTextInput: true,
					    step: 15,
					    timeFormat : 'H:i',
					    maxTime : '17:00',
					    minTime : '12:30'
					});
	        }
	    }
	},
	addParams = {	
		useFormatter : false,
		position: "last", 
		addRowParams: { 
						  successfunc :  function (a){
								 var $self = $(this);
						            setTimeout(function () {
					                $self.trigger("reloadGrid");
					            }, 50);						        						     
						            
					     },
					    /* oneditfunc  :  function(rowId){
					    	 if (rowId && rowId !== lastSelection) {					    	        
					    	        lastSelectedRow = rowId;
					    	    }
					     }*/
				
			}
	        
	    }
	, 
	navParams = {
		   edit: false,
		   add: false,
		   del: true,
		   search:false,
		   refresh:false,
		   position : "right",
		   alertcap: "שים לב"
	}
	,inlinNavParameters = { 
			   edit: true,
			   editicon: "ui-icon-pencil",
			   add: true,
			   addicon:"ui-icon-plus",
			   save: true,
			   saveicon:"ui-icon-disk",
			   cancel: true,
			   cancelicon:"ui-icon-cancel",
			   addParams : addParams,
			   editParams : { errorfunc: function (rowID, response) {
					  debugger;
						//alert(response.responseText);
					    // todo: why this does not allow Enter key to continue ase after error:
						$.jgrid.info_dialog("שגיאה",'<div class="ui-state-error">'+
							    "שגיאה בשמירת נתונים" +'</div>', "סגור",{buttonalign:'right', modal : true});
						/*$.jgrid.info_dialog($.jgrid.errors.errcap,'<div class="ui-state-error">'+
							    response.responseText +'</div>', $.jgrid.edit.bClose,{buttonalign:'right'});*/
					}, 
					successfunc : function (response) {
					   
						console.log(response.responseText);
						var $self = $(this);
			            setTimeout(function () {
		                $self.trigger("reloadGrid");
		            }, 50);
						return true; 
					},
					/*
					oneditfunc : function(id){
						
					}*/
					afterrestorefunc : function(response ){

					}
			   },
			   del: true,
			   
			   
	} ;

function validatePhone (val,cellName,nm,valref){
	var phoneno = /^(05[0-9]{1})[-]?([0-9]{3})[-]?([0-9]{4})$/;  
	var p = $(this).jqGrid("getGridParam");
	  if((val.match(phoneno)) ) 
      {  
		  return [true,""]; 
      }  
      else  
      {  
    	  return [false, "מספר טלפון לא תקין"];
      }  
}

function formatGradeCell(rowId, val, rawObject, cm, rdata){
	//"style" : "background:"+colors.future+";","data-isHistory": false
	var cellVal='';
	if(valuesFroCell){
		var valuesFroCellCopy = valuesFroCell.split(";");
	    $.each(valuesFroCellCopy, function(key, value) {  
	    	value  = value.split(":");
	    	
    		if(val == value[1]){
    			cellVal =  'style="background-color:'+ value[2]+'; font-weight:bold;"';	    			
    		//$select.append('<option style="background-color:'+ value[2]+'" value=' + value[0] + '>' + value[1] + '</option>');
    		}
	    	
	    });
	}
	
	if(rawObject.gradeColor){
		cellVal =  'style="background-color:'+ rawObject.gradeColor+'; font-weight:bold;"';
	}
	
	return cellVal;
}
function saveSelectVal(e){

	if(e.target && e.target.value){
		selectedValue = e.target.value;
	}
	
}

// not in use
function checkArray(grid){
	if(allValues && allValues.length > 0 && selectedValue){
		var newValue = "";
		for (var int = 0; int < allValues.length; int++) {
			if(allValues[int][0] == selectedValue ) continue;
			newValue += allValues[int].join(':') + ";";
		}
		newValue = newValue.substring(0,newValue.lastIndexOf(";"));
		grid.jqGrid('setColProp', 'gradeID', {editoptions: { value:  newValue}});
	}
}

function updateSelectOptions(grid, data, cellName){
	var options = grid.jqGrid('getColProp', cellName).availableOptions, cellValue;
	canAdd = true;
	
	if(options && options.length > 0 && data.rows){
		var newValue = "";
		var isNotExisted;
		for (var int = 0; int < options.length ; int++) {
			isNotExisted = true;
			for (var i = 0; i < data.rows.length; i++) {
				if(options[int][1] == data.rows[i][cellName] ){ 
					isNotExisted = false;
					break;
				}																						
			}
			
			if(isNotExisted)
			newValue += options[int].join(':') + ";";
			
		}
		
		//check if value of select is valid
		cellValue = newValue = newValue.substring(0,newValue.lastIndexOf(";"));
		
		if(cellValue.length == 0 || cellValue.split(':').length == 0) canAdd =  false;
		
		cellValue = cellValue.split(':');
		
		if(cellValue[0] == null || cellValue[0]  == '') canAdd =  false;
		
		// if value of select is valid , we can enable add button
		if(canAdd){
			$("#list_iladd").removeClass("ui-state-disabled");
			$("#list_iladd").prop('title', 'הוסף שורה חדשה');
			setInfoMsg(null, false, null);
		}
		else{
			$("#list_iladd").addClass("ui-state-disabled");
			$("#list_iladd").prop('title', 'לא ניתו להוסיף רשומות, כל אפשרויות הבחירה נוספו');
			setInfoMsg('לא ניתן להוסיף רשומות, כל אפשרויות הבחירה נוספו', true, 'alert alert-warning');
		}
		grid.jqGrid('setColProp', cellName, {editoptions: { value:  newValue}});
	}
	
}
/**
 * set the client array of cols (colname Object) wich is used in grid 
 * @param result - the array  object from server with the cols data
 */
function setColModelFormResult(result){
	 cols = JSON.parse(result);
	 colname  = new Array();
	 var width= null;
	 var search, newstr, tempVal;
	if(selectedTab === "tbl_reg_types")
		width = 50;
	 //Loop into the column values collection and push into the array.
	$.each(cols, function () {
	
	//Check the datatype of the column.
	if(this.IsKey){
		tablePk = this.Name;		
	}	
	var cm = {
			//width : width == null ? "auto" : width,
	        name: this.Name,
	        hidden: this.IsHidden ,//|| !existingProperties.hasOwnProperty(this.Name)
	        editable : this.editable,
	        editoptions: this.DefaultValue != null && this.DefaultValue != "" ? { defaultValue: this.DefaultValue } : {},
	        editrules: { required: this.IsRequired },
	        label : this.label,
	        key: this.IsKey,
	       
	    };
	//"yearID",  "endMonth" "startMonth" "tbl_school_years"
	switch (this.Datatype) {
	    case 'int':
	    	/*$.extend(true, cm, { template: integerTemplate }, { editrules: {integer : true} });*/
	    	 $.extend(true, cm, { template: integerTemplate } , { editrules: { integer: true } });
	    	 if(typeof tableName !== "undefined" && ( tableName === "tbl_grade_in_year" || tableName === "tbl_moadonit_groups") ){
	    		 if(this.Name == "yearID" &&  currentYearObject != null && typeof currentYearObject === 'object')
	    		{
	    			 $.extend(true, cm, { editoptions :  { defaultValue: currentYearObject.yearID }});
	    		}	    		
	    	 }
	    	 break;
	    case 'float':
	        $.extend(true, cm, { template: floatTemplate }  , { editrules: { number: true } });
	        lastFieldName = cm.name; //Store the fieldName.
	        break;
	    case 'Date':
	        $.extend(true, cm, { template: dateTemplate } , { editrules: { date: true } });
	        lastFieldName = cm.name;
	        if(typeof tableName !== "undefined" && tableName === "tbl_moadonit_groups" ){
	    		 if(this.Name == "endMonth" &&  currentYearObject != null && typeof currentYearObject === 'object')
	    		{
	    			 $.extend(true, cm, { editoptions :  { defaultValue: currentYearObject.endDate }});
	    		}		    		 
    		    else if(this.Name == "startMonth" &&  currentYearObject != null && typeof currentYearObject === 'object')
	    		{
    		    	 var d = new Date();
	    			 $.extend(true, cm, { editoptions :  { defaultValue: d.getTime() }});
	    		}	
	    	 }
	        break;
	    case 'time':
	        $.extend(true, cm, { template: timeTemplate } , { editrules: { time: true } });
	        lastFieldName = cm.name;
	        break; 
	    case 'dropdown':
	        var values = this.ValueList.slice(0, -1);
	        tempVal = values.split(';');
	        allValues = new Array();
	        allValues = new Array();
        	for (var int = 0; int < tempVal.length; int++) {
        		//save select option values in array.
        		allValues.push(tempVal[int].split(':'));
			}
        	
	        $.extend(true, cm, { template: dropdownTemplate,
	            editoptions: { value:  values, defaultValue: this.DefaultValue },availableOptions : allValues
	            //searchoptions: { value: ":;" + values }
	        }
	        /*,
	        this.ValueType == "F" ? { label: this.ValueId } : {}
	        */
	        );
	      
	        break;
	    case 'custom':
	        valuesFroCell = this.ValueList.slice(0, -1);
	        if(typeof tableName !== "undefined" && (tableName === "tbl_grade_in_year" || tableName === "tbl_moadonit_groups") ){
	             search = /\:#[a-z0-9]{6}/ig;   // regex to find color pattern
	        	 newstr = valuesFroCell.split(search).join('');  // create select values without color value
	        	 tempVal = newstr.split(';');
	        	allValues = new Array();
	        	for (var int = 0; int < tempVal.length; int++) {
	        		//save select option values in array.
	        		allValues.push(tempVal[int].split(':'));
				}
	        	//console.log(newstr);
	        	 $.extend(true, cm,   { template: dropdownTemplate,
		 	            editoptions: { value:  newstr, defaultValue: this.DefaultValue , 
		 	            	dataEvents: [ { type: 'change', fn: function(e) { saveSelectVal(e); } } , ]},
		 	            	cellattr: formatGradeCell, availableOptions : allValues });
	        	 
	        }else{
	        	 $.extend(true, cm,   { template: dropdownTemplate,
	 	            editoptions: { value:  valuesFroCell, defaultValue: this.DefaultValue },
	 	           /* searchoptions: { value: ":All;" + values },*/  
	 	            cellattr: formatGradeCell 
	 	        });
	        }
	       
	        break;   
	    case 'colorpicker':
	        $.extend(true, cm, { template: colorpickerTemplate , cellattr: formatGradeCell} );
	        break;    
	    case 'phone':
	        $.extend(true, cm, { template: phoneTemplate } );
	        break;
	    case "email":
	    	$.extend(true, cm,   { 
	    		editrules: { email:true }
 	        });
	    	break;
	    default:
	    	$.extend(true, cm,   { 
	    		editrules: { custom:true, custom_func:validateTextOnly }
 	        });
	        break;
	}
	if (cm)
	colname.push(cm);
	});
	sortname = (selectedTab === "tbl_activity" ? "activityName" : tablePk);
}


var validateTextOnly = function (value, colname) {
    if (/^[א-תa-zA-Z -]+$/i.test(value)) {
        return [true];
    } else {
        return [false, "טקסט לא תקין בשדה '" + colname + "'."]
    }
};

/***
 * show info msg
 * @param msgHtml - msg content (string)
 * @param msgStatus - dispay status (bolean)
 * @param msgCss - msg style (string)
 */
function setInfoMsg(msgHtml,msgStatus, msgCss){
	if(msgHtml != null) $('#InfoMsg').html("<strong>שיב לב</strong> " + msgHtml);
	$('#InfoMsg').removeClass();
	if(msgCss != null) $('#InfoMsg').addClass( msgCss);
	$('#InfoMsg').toggle(msgStatus);	
}

function getGeneralGrid(){
	
	$.ajax({
		async : false,
		type : 'POST',
		datatype : 'jsonp',
		url : "LogisticsController",
		data : { action : "getMetaData", tableName : tableName, query: query, whereclause : whereclause  },
		success : function(data) {
			if (data != undefined) {
				
				setColModelFormResult(data.cols);
				
			    var grid = $("#list");
				
			    grid.jqGrid(
						{

							
							url : "LogisticsController?action=getGridRows&tableName=" +tableName,
							datatype : "json",
							mtype : 'POST',
					        colModel: colname,
							pager : '#pager',
							autowidth : true,
							shrinkToFit : true,
							rowNum : 20,
							rowList : [],						
							direction : "rtl",
							viewrecords : true,
							gridview : true,
							height : "auto",
							width : "auto",
							editurl : "LogisticsController?tableName=" + tableName,
							jsonReader : {
								repeatitems : false,
							},
							recreateFilter : true,
							sortname : sortname,
							autoencode: true,
							//pgbuttons : false, // disable page control like next, back
							// button
							//pgtext : null, // disable pager text like 'Page 0 of 10'
							/*new change */
							localReader: { id: tablePk },
							prmNames: { id: tablePk },
							/*new change*/
							onInitGrid: function () {
						        
							       //var p = $(this).jqGrid("getGridParam");
	
							        // set data parameter
							        //p.data = rows;
							       
							    
						    },

						    afterSubmit: function (response, postdata) {
						    	
						    	return [false,response.responseText] ;
								   debugger;
									//alert(response.responseText);
								    // todo: why this does not allow Enter key to continue ase after error:
									$.jgrid.info_dialog("שגיאה",'<div class="ui-state-error">'+
										    response.responseText +'</div>', "סגור",{buttonalign:'right', modal : true});
									$.jgrid.info_dialog($.jgrid.errors.errcap,'<div class="ui-state-error">'+
										    response.responseText +'</div>', $.jgrid.edit.bClose,{buttonalign:'right'});
							},
							
							loadError: function (jqXHR, textStatus, errorThrown) {
								debugger;
								alert('HTTP status code: ' + jqXHR.status + '\n' +
			                          'textStatus: ' + textStatus + '\n' +
			                          'errorThrown: ' + errorThrown);
			                    alert('HTTP message body (jqXHR.responseText): ' + '\n' + jqXHR.responseText);
			                },
							serializeRowData: function(postdata) { 
								
								switch (tableName) {
							    case 'tbl_activity':
							    	if(currentYearObject != null && typeof currentYearObject === 'object')
						    		{
							    		postdata.schoolYear =  currentYearObject.yearID;
						    		}
							        break;
							    default:
							        break;
								}
								
								return postdata;
								//return { rtm : JSON.stringify(createPostData(pupilID, postdata,true)), _oldDateVal: oldDateVal.getTime() , _oldEndDate: oldEndDate.getTime() } ;
					        },
							rowattr : function(rd) {
								
								if(typeof tableName !== "undefined" && tableName === "tbl_reg_types" ){
									
									if(rd.typeNum == 1 ||  rd.typeNum == 2){ // 
										return {
											"class" : 'not-editable-row',
											/*"style" : "background:#9E9F9F;",*/
											"data-uneditable": true
										};
									}
								}

							},
							afterInsertRow: function (rowid, rowdata, rowelem) {
								//jqg28
								
								if(rowid.startsWith('jqg')){
									rowid = rowid.substring(0,3);
								}
							},
							onSelectRow: function(id) { 														
								/*if(id.startsWith('jqg'))
									id = id.substring(3,id.length);*/
								
								if(btnEdit.length > 0 &&  btnEdit.hasClass("disabledbutton"))
									btnEdit.removeClass("disabledbutton");	
								if(btnDel.length > 0 &&  btnDel.hasClass("disabledbutton"))
									btnDel.removeClass("disabledbutton");
								
								if(typeof tableName !== "undefined" && tableName === "tbl_reg_types" ){
									if (id && (id == 1 || id == 2)) {
										var grid = $("#list");
										//grid.jqGrid('restoreRow', id);
										
										var isUneditable = $('#gview_list div #'+ id).attr('data-uneditable');
										
										if (isUneditable === 'true') {											
											if(btnEdit.length > 0 )
												btnEdit.addClass("disabledbutton");			
											if(btnDel.length > 0 )
												btnDel.addClass("disabledbutton");			
										}														
										
									}else{
										if(btnEdit.length > 0 &&  btnEdit.hasClass("disabledbutton"))
											btnEdit.removeClass("disabledbutton");	
										if(btnDel.length > 0 &&  btnDel.hasClass("disabledbutton"))
											btnDel.removeClass("disabledbutton");	
									}
								}								
								else if(typeof tableName !== "undefined" && (tableName === "tbl_grade_in_year" || tableName === "tbl_moadonit_groups" ) ){
									if (id && !isNaN(id) && id !== lastSelection) {
										
										
										if ($("tr#"+id).attr("editable") !== "1") { // if the row is in edit process
										    // the row having id=rowid is in editing mode
											$(this).jqGrid('setColProp', 'gradeID', {editable:false}); // disable cell editing
										}
										
										lastSelection = id;
									}else if(isNaN(id)){
										lastSelection = -1;
									}
									
									/*if(btnEdit.length > 0 &&  btnEdit.hasClass("disabledbutton"))
										btnEdit.removeClass("disabledbutton");	
									if(btnDel.length > 0 &&  btnDel.hasClass("disabledbutton"))
										btnDel.removeClass("disabledbutton");*/
								}
								else if(typeof tableName !== "undefined" && tableName === "tbl_grade_code" ){
									var selectedID =parseInt(id,0);
									
									if (id && !isNaN(id) && id !== lastSelection) {
										
										
										if ($("tr#"+id).attr("editable") !== "1") { // if the row is in edit process
										    // the row having id=rowid is in editing mode
											$(this).jqGrid('setColProp', 'shichva', {editable:false}); // disable cell editing
										}
										
										lastSelection = id;
									}
									
									
								/*	if(btnEdit.length > 0 &&  btnEdit.hasClass("disabledbutton"))
										btnEdit.removeClass("disabledbutton");	
									if(btnDel.length > 0 &&  btnDel.hasClass("disabledbutton"))
										btnDel.removeClass("disabledbutton");*/
								}
								else{
									
									/*if(btnEdit.length > 0 &&  btnEdit.hasClass("disabledbutton"))
										btnEdit.removeClass("disabledbutton");	
									if(btnDel.length > 0 &&  btnDel.hasClass("disabledbutton"))
										btnDel.removeClass("disabledbutton");	*/
								}
																
					        },
							loadComplete : function(data) {
								
								gridRowsData = data;
								if(typeof tableName !== "undefined" && tableName === "tbl_school_years" ){									
									prepareYearsForm();
									
								}
								if(typeof tableName !== "undefined" && (tableName === "tbl_grade_in_year" || tableName === "tbl_moadonit_groups") ){
									updateSelectOptions(grid, data, 'gradeID');
								}
								else if(typeof tableName !== "undefined" && tableName === "tbl_activity" ){
									//updateSelectOptions(grid, data, 'responsibleStaff');
								}
							}
							
						}).jqGrid("navGrid", "#pager", navParams)
						.jqGrid("inlineNav","#pager", inlinNavParameters );
			        
				$.extend($.jgrid.inlineEdit, { restoreAfterError: false } );	
				
				var btnSave, btncancel, btnEdit, btnDel, btnAdd;
				btnSave = $("#list_ilsave"); 
				btncancel = $("#list_ilcancel");
				btnEdit = $("#list_iledit");
				btnDel = $("#del_list");
				btnAdd = $("#list_iladd");
				
				var origAddRowDataFunc = $.fn.jqGrid.addRowData;
				var origShowAddEditButtons =  $.fn.jqGrid.showAddEditButtons;
				$.fn.jqGrid.showAddEditButtons = function(rowid,rdata,pos,src) {
					
					

					var res = origShowAddEditButtons.call(this);
					if(canAdd){
						$("#list_iladd").removeClass("ui-state-disabled");
						$("#list_iladd").prop('title', 'הוסף שורה חדשה');
						setInfoMsg(null, false, null);
					}
					else{
						$("#list_iladd").addClass("ui-state-disabled");
						$("#list_iladd").prop('title', 'לא ניתו להוסיף רשומות, כל אפשרויות הבחירה נוספו');
						setInfoMsg('לא ניתו להוסיף רשומות, כל אפשרויות הבחירה נוספו', true, 'alert alert-warning');
					}
					
				};

				$.fn.jqGrid.addRowData = function(rowid,rdata,pos,src) {
					
					if(typeof tableName !== "undefined" && tableName === "tbl_grade_code" ){
						$(this).jqGrid('setColProp', 'shichva', {editable:true}); 
					}
					else if(typeof tableName !== "undefined" && (tableName === "tbl_grade_in_year" || tableName === "tbl_moadonit_groups" )){
						$(this).jqGrid('setColProp', 'gradeID', {editable:true});						
					}

					result = origAddRowDataFunc.call(this,rowid,rdata,pos,src);
					
				};
				
					
/*				
 * 
 * 	var allRowsInGrid = $('#list4').jqGrid('getGridParam','data');
 * 				var originalDelFunc = $.fn.jqGrid.delGridRow;
			    $.fn.jqGrid.delGridRow = function (rowids, oMuligrid) {
			        var onPreDeleteRowEventHandler = this.getGridParam('onPreDeleteRow'),
			            consumeFlag = false;
			        $.extend(oMuligrid, { afterSubmit: function(response, postdata){ 
			        	
			        	var $this = $(this), id = $.jgrid.jqID(this.id), p = this.p,
		                newPage = p.page;
			        	
			        	 $.jgrid.hideModal("#delmod" + id, {});

			             if (p.lastpage > 1) {// on the multipage grid reload the grid
			                 if (p.reccount === 0 && newPage === p.lastpage) {
			                     // if after deliting there are no rows on the current page
			                     // which is the last page of the grid
			                     newPage--; // go to the previous page
			                 }
			                 // reload grid to make the row from the next page visable.
			                 $this.trigger("reloadGrid", [{page: newPage}]);
			             }
			             
			             if(response.status == 200){
			            		$.jgrid.info_dialog("הודעה",'<div class="ui-state-default">'+
									    "רשומה נמחקה בהצלחה" +'</div>', "סגור",{buttonalign:'right'});
			             }else{
			            		$.jgrid.info_dialog("הודעה",'<div class="ui-state-error">'+
									    response.responseText +'</div>', "סגור",{buttonalign:'right'});
			             }
			             
			        
			        	}
			        }
			        );
			        originalDelFunc.call(this, rowids, oMuligrid);
			        
			        if (typeof onPreDeleteRowEventHandler === 'function') {
			            consumeFlag = !!onPreDeleteRowEventHandler(rowids, oMuligrid);
			        }

			        if (!consumeFlag) {
			            originalDelFunc.call(this, rowids, oMuligrid);
			        }
			    };*/
				  
			    /*grid.jqGrid(
			            	'setGridParam',
				            {
				                onPreDeleteRow: function(rowids, oMuligrid) {
				                    // remove client data here
				                	alert("onPreDeleteRow event");
				                }
			            		
				            }
		      );*/
			    
			} else
				alert("לא קיימים נתונים");
		},
		error : function(e) {
			alert("שגיאה בשליפת נתונים");
			console.log("error");

		}

	});
	
}



