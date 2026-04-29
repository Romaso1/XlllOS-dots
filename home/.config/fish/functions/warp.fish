function warp
    switch "$argv[1]"
        case on
            echo "Starting Cloudflare WARP..."
            sudo systemctl start warp-svc.service
            sleep 1
            warp-cli connect
            warp-cli status

        case off
            echo "Stopping Cloudflare WARP..."
            warp-cli disconnect 2>/dev/null
            sudo systemctl stop warp-svc.service
            echo "WARP disabled."

        case status ""
            warp-cli status 2>/dev/null || echo "WARP service is not running."

        case "*"
            echo "Usage:"
            echo "  warp on      - enable Cloudflare WARP"
            echo "  warp off     - disable Cloudflare WARP"
            echo "  warp status  - show WARP status"
    end
end
