function pdf_path = generate_pdf(xml_path, problem_cell_array)
    import mlreportgen.report.*
    import mlreportgen.dom.*

    timestamp = datetime('now','TimeZone','local','Format','yyyy_MM_dd_hh_mm_ss');
    doc = Report(sprintf("%s_statements", timestamp), "pdf");

    statement_template = readstruct(xml_path);

    for j = 1: length(problem_cell_array)
        if j > 1
            add(doc, PageBreak());
        end

        problem = problem_cell_array(j);
        for i = 1:length(statement_template.p)
            p = statement_template.p(i);
            text = build_text(p, problem);
            if isequal(p.classAttribute, "latex")
                add(doc, Equation(text));
            else
                add(doc, Paragraph(text));
            end
            add(doc, LineBreak);
        end
        
    end
    close(doc);
    pdf_path = doc.OutputPath;
end

function final_text = build_text(p, problem)
    vars = p.var;
    if ismissing(vars)
        length_vars = 0;
    else
        length_vars = length(vars);
    end

    texts = p.Text;
    if ismissing(texts)
        length_texts = 0;
    else
        length_texts = length(texts);
    end
    
    if length_vars >= length_texts && length_vars > 0
        % start with the variable
        final_text = resolv_var(p.var(1), problem);
        var_index = 1;
    else
        final_text = '';
        var_index = 0;
    end

    for text_index = 1:length_texts
        final_text = strcat(final_text, texts(text_index));
        var_index = var_index + 1;
        if var_index <= length_vars
            final_text = strcat(final_text, resolv_var(vars(var_index), problem));
        end
    end

    while var_index < length_vars
        var_index = var_index + 1;
        final_text = strcat(final_text, resolv_var(vars(var_index), problem));
    end
end

function string_value = resolv_var(varname, problem)
    value = problem.(varname);
    string_value = ' ' + string(value) + ' ';
end
