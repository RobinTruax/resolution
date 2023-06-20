            -- proper placement
            local resolve = require('telescope.config.resolve')
            resolve.resolve_anchor_pos = function(anchor, p_width, p_height, max_columns, max_lines)
                anchor = anchor:upper()
                local pos = { 0, 0 }
                if anchor == 'CENTER' then
                    return pos
                end
                if anchor:find 'W' then
                    pos[1] = math.ceil((p_width - max_columns) / 2) + 1
                elseif anchor:find 'E' then
                    pos[1] = math.ceil((max_columns - p_width) / 2) - 1
                end
                if anchor:find 'N' then
                    pos[2] = math.ceil((p_height - max_lines) / 2) + 1
                elseif anchor:find 'S' then
                    pos[2] = math.ceil((max_lines - p_height) / 2)
                end
                return pos
            end
